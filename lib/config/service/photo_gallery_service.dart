import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';
import 'package:flutter_bump_app/utils/lazy_list/lazy_list_controller.dart';
import 'package:flutter_bump_app/utils/logger_helper.dart';
import 'package:flutter_bump_app/utils/my_permission_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

const maxMedium = 5;
const _LIMIT_IMAGE = 40;

class AlbumModel {
  final AssetPathEntity album;
  final List<PhotoMediaAsset> media;
  final int total;

  String get name => album.name;

  AlbumModel(this.album, this.media, this.total);

  AlbumModel copyWith({
    AssetPathEntity? album,
    List<PhotoMediaAsset>? media,
    int? total,
  }) {
    return AlbumModel(
      album ?? this.album,
      media ?? this.media,
      total ?? this.total,
    );
  }
}

class PhotoMediaAsset {
  final AssetEntity assetEntity;
  final Uint8List? thumbnailByte;
  final File? imageFile;

  PhotoMediaAsset(
      {required this.assetEntity, this.imageFile, this.thumbnailByte});
}

typedef OnMediumsUpdate = void Function(List<PhotoMediaAsset> mediums);

@singleton
class PhotoGalleryService {
  final albums = BaseStreamController<List<AlbumModel>>([]);
  final currentAlbum = BaseStreamController<AlbumModel?>(null);
  final isLoading = BaseStreamController(false);
  int _currentAlbumIndex = 0;

  late final LazyListController<PhotoMediaAsset> mediaListCtrl =
      LazyListController<PhotoMediaAsset>(
          limit: _LIMIT_IMAGE,
          onLoad: (int page) async {
            final medias = await currentAlbum.value?.album
                    .getAssetListPaged(page: page - 1, size: _LIMIT_IMAGE) ??
                [];

            final result = await _convertListAssetEntity(medias);
            addMediaToAlbum(result);
            return result;
          });

  OnMediumsUpdate? onMediumsUpdate;
  bool hasInit = false;
  bool isRequestFinish = false;
  bool isShowAlbum = false;

  final List<PhotoMediaAsset> _imageInScreen = <PhotoMediaAsset>[];

  Future<void> checkAndInitService() async {
    final isAccept = await checkPermission();
    if (isAccept) {
      await onInit();
    }
  }

  @disposeMethod
  void dispose() {
    isLoading.dispose();
    albums.dispose();
    currentAlbum.dispose();
    mediaListCtrl.dispose();
  }

  void addMediaToAlbum(List<PhotoMediaAsset> result) {
    try {
      final list = [...albums.value];
      final newMedias = <PhotoMediaAsset>[];
      if (mediaListCtrl.list.length == 1) {
        newMedias.addAll(result);
      } else {
        newMedias.addAll([...mediaListCtrl.list, ...result]);
      }
      list[_currentAlbumIndex] =
          list[_currentAlbumIndex].copyWith(media: newMedias);
      albums.value = list;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isAcceptPermission() async {
    final result = await PhotoManager.requestPermissionExtend();
    return result.hasAccess || result.isAuth;
  }

  Future<bool> checkPermission() async {
    final result = await PhotoManager.getPermissionState(
        requestOption: const PermissionRequestOption());
    return result.hasAccess || result.isAuth;
  }

  Future<void> requestPermission() async {
    return MyPermissionHandler.requestPermission(
        Platform.isIOS ? Permission.photos : Permission.storage);
  }

  Future<void> onInit() async {
    if (hasInit) return;
    hasInit = true;
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      isRequestFinish = true;
    });
    try {
      loggerHelper.logCyan('onInit');
      final result =
          await PhotoManager.getAssetPathList(type: RequestType.video);
      final models = <AlbumModel>[];
      loggerHelper.success('init success');
      for (final item in result) {
        final total = await item.assetCountAsync;
        if (total > 0) {
          final mediaResult = await item.getAssetListPaged(page: 0, size: 1);
          final photoMedias = await _convertListAssetEntity(mediaResult);
          models.add(AlbumModel(item, photoMedias, total));
        }
      }
      albums.value = models;
      if (models.isNotEmpty) {
        currentAlbum.value = models.first;
        loggerHelper.success('select album success');
        mediaListCtrl.onRefresh();
      }
    } catch (e) {
      print(e);
      hasInit = false;
    }
    isLoading.value = false;
  }

  void onRefresh() {
    hasInit = false;
    currentAlbum.value = null;
    onInit();
  }

  Future<void> presentLimited() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission == PermissionState.limited) {
      await PhotoManager.presentLimited();
    }
  }

  void resetAlbumMedia() {
    final list = [...albums.value];
    for (var i = 0; i < list.length; i++) {
      list[i] = list[i].copyWith(
          media: list[i].media.isNotEmpty ? [list[i].media.first] : []);
    }
    albums.value = list;
    // clearSelection();
    mediaListCtrl.isOutOfRange = false;
  }

  // void onChangeAlbum(AlbumModel album) async {
  //   if (currentAlbum.value?.album.id == album.album.id) return;
  //   currentAlbum.value = album;
  //   _currentAlbumIndex =
  //       albums.value.indexWhere((e) => e.album.id == album.album.id);
  //   mediaListCtrl.list = album.media;
  //   mediaListCtrl.isOutOfRange = false;
  //   mediaListCtrl.isLoadMore = false;
  //   if (mediaListCtrl.list.length == 1) {
  //     mediaListCtrl.onRefresh();
  //   } else {
  //     mediaListCtrl.page = mediaListCtrl.list.length ~/ _LIMIT_IMAGE;
  //     mediaListCtrl.isOutOfRange = mediaListCtrl.list.length >= album.total;
  //   }
  // }

  Future<List<PhotoMediaAsset>> _convertListAssetEntity(
      List<AssetEntity> assets) async {
    return Future.wait(assets.map((e) => _convertMedia(e)));
  }

  Future<PhotoMediaAsset> _convertMedia(AssetEntity asset) async {
    File? file = null;
    Uint8List? thumbnailByte = null;
    if (asset.type == AssetType.image) {
      file = await asset.loadFile();
      if (file?.path.endsWith('HEIC') == true) {
        thumbnailByte =
            await asset.thumbnailDataWithSize(const ThumbnailSize(500, 500));
      }
    } else {
      thumbnailByte =
          await asset.thumbnailDataWithSize(const ThumbnailSize(500, 500));
    }
    return PhotoMediaAsset(
        assetEntity: asset, thumbnailByte: thumbnailByte, imageFile: file);
  }

  void addImageInScreen(PhotoMediaAsset photo) {
    _imageInScreen.add(photo);
  }

  void removeImageInScreen(PhotoMediaAsset photo) {
    _imageInScreen.remove(photo);
  }
}
