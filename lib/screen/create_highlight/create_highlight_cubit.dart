import 'dart:io';

import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/service/photo_gallery_service.dart';
import 'package:flutter_bump_app/data/repository/video/ivideo_repository.dart';
import 'package:flutter_bump_app/data/usecase/upload_usecase_mixin.dart';
import 'package:flutter_bump_app/data/usecase/upload_video_usecase.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_state.dart';

class CreateHighlightCubit extends BaseCubit<CreateHighlightState> {
  final IVideoRepository videoRepository = locator.get();
  final AccountService accountService = locator.get();
  final UploadVideoUseCase uploadVideoUsecase = locator.get();
  final PhotoGalleryService photoGalleryService = locator.get();

  CreateHighlightCubit() : super(const CreateHighlightState());

  final uploadProgress = BaseStreamController<double>(0.0);

  List<PhotoMediaAsset> selectedVideos = [];

  @override
  Future<void> close() {
    uploadProgress.dispose();
    return super.close();
  }

  @override
  void onInit() {
    super.onInit();
    photoGalleryService.checkAndInitService();
  }

  void toggleVideoSelection(PhotoMediaAsset video) {
    final id = video.assetEntity.id;
    final currentSelection = List<String>.from(state.selectedVideoIds);

    final index = currentSelection.indexOf(id);
    if (index >= 0) {
      currentSelection.removeAt(index);
      selectedVideos.removeAt(index);
    } else {
      currentSelection.add(id);
      selectedVideos.add(video);
    }

    emit(state.copyWith(selectedVideoIds: currentSelection));
  }

  void clearSelection() {
    emit(state.copyWith(selectedVideoIds: []));
  }

  void updateHighlightName(String name) {
    // emit(state.copyWith(highlightName: name));
  }

  // Future<bool> createHighlight() async {
  //   if (state.highlightName.trim().isEmpty) {
  //     return false;
  //   }

  //   emit(state.copyWith(isLoading: true));

  //   try {
  //     // Simulate API call to create highlight
  //     await Future.delayed(const Duration(seconds: 2));

  //     // In real app, call API
  //     // final result = await accountService.createHighlight(
  //     //   name: state.highlightName,
  //     //   videoIds: state.selectedVideoIds,
  //     // );

  //     emit(state.copyWith(
  //       isLoading: false,
  //       showNameDialog: false,
  //       highlightName: '',
  //       selectedVideoIds: [],
  //     ));

  //     return true;
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: false));
  //     return false;
  //   }
  // }

  Future<void> recordVideo() async {
    // Handle video recording
    // This would typically open camera/recording interface
    emit(state.copyWith(isLoading: true));

    // Simulate recording process
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isLoading: false));
  }

  Future<void> uploadVideo(File file) async {
    uploadProgress.value = 0.0;
    await uploadVideoUsecase.call(
      UploadVideoUseCaseParam(
        uploadUseCaseParam: UploadUseCaseParam(
          file: file,
          type: PreSignUrlType.video,
        ),
        onProgress: (progress, total) {
          uploadProgress.value = (progress / total) * 100;
        },
      ),
    );
  }

  // Future<void> uploadVideo() async {
  //   // Handle video upload
  //   // This would typically open file picker
  //   emit(state.copyWith(isLoading: true));

  //   // Simulate upload process
  //   await Future.delayed(const Duration(seconds: 1));

  //   emit(state.copyWith(isLoading: false));
  // }

  Future<void> refreshLibrary() async {
    emit(state.copyWith(isLoading: true));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // In real app, fetch from API
    // final items = await accountService.getUserVideoLibrary();

    emit(state.copyWith(isLoading: false));
  }
}
