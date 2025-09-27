import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bump_app/utils/flash/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dialog.dart';
import 'my_permission_handler.dart';

class ImagePickerHandler {
  static final _picker = ImagePicker();

  static Future<bool> requestPermission() async => Platform.isAndroid
      ? await MyPermissionHandler.systemRequestPermission(Permission.photos)
      : await MyPermissionHandler.systemRequestPermission(Permission.storage);

  static Future<File?> onGetVideo() async {
    try {
      final result = await _picker.pickVideo(
          source: ImageSource.gallery,
          preferredCameraDevice: CameraDevice.front);
      if (result != null) {
        return File(result.path);
      }
    } catch (e) {
      showSimpleToast('You have denied the photo permission');
    }

    return null;
  }

  static Future<File?> onGetImage({ImageSource? source}) async {
    try {
      final result = await _picker.pickImage(
        source: source ?? ImageSource.gallery,
      );
      if (result != null) {
        return File(result.path);
      }
    } catch (e) {
      showSimpleToast('You have denied the photo permission');
    }

    return null;
  }

  static Future<File?> onTakeCamera() async {
    // final isAllow = await requestPermission();
    // if (isAllow) {
    try {
      final result = await _picker.pickImage(source: ImageSource.camera);
      if (result != null) {
        return File(result.path);
      }
    } catch (e) {
      if (e is PlatformException) {
        // if (e.code == ErrorPlatform.CAMERA_DENIED) {
        MyPermissionHandler.requestPermission(Permission.camera);
        // }
      } else {
        showSimpleToast('You have denied the photo permission');
      }
    }
    // } else {
    //   showSimpleToast('You have denied the photo permission');
    // }

    return null;
  }

  static Future<List<File>> onGetMultipleImage() async {
    // final isAllow = await requestPermission();
    // if (isAllow) {
    try {
      final result = await _picker.pickMultiImage();
      if (result.isNotEmpty) {
        return result.map((value) => File(value.path)).toList();
      }
    } catch (e) {
      showSimpleToast('You have denied the photo permission');
    }
    // } else {
    //   showSimpleToast('You have denied the photo permission');
    // }

    return [];
  }

  /// NOTE: If you want to pick image, you can use this function
  /// Default bottom sheet system for picking image from gallery or camera
  /// This use image picker from package:image_picker
  /// getImages: you will get the list of files but when you just get one image, you will get the list with one element. If you want to get multiple files, you just let it default
  /// postMedias, mediaIndex: this selection is when show this bottom sheet, you can navigate to preview image detail with certain index
  static showCupertinoImages(
    BuildContext context, {
    bool getOneImage = false,
    bool getVideo = false,
    File? file,
    Function(List<File> files)? getImages,
  }) {
    return DialogUtils.showCupertinoModal(
      context,
      [
        // if (file != null)
        //   CupertinoAction(
        //     onTap: () {
        //       // if (locator.isRegistered<IGlobalConfigRepository>())
        //       //   locator.get<IGlobalConfigRepository>().navigateImage(
        //       //       file: file,
        //       //       videoMedia: postMedias.toList(),
        //       //       mediaIndex: mediaIndex);
        //     },
        //     title: 'View image',
        //   ),
        CupertinoAction(
          onTap: () {
            ImagePickerHandler.onTakeCamera().then((values) {
              if (values != null) {
                getImages?.call([values]);
              }
            });
          },
          title: 'Take photo',
        ),
        CupertinoAction(
          onTap: () {
            if (getOneImage) {
              ImagePickerHandler.onGetImage().then((values) {
                if (values != null) {
                  getImages?.call([values]);
                }
              });
            } else {
              ImagePickerHandler.onGetMultipleImage()
                  .then((values) => getImages?.call(values));
            }
          },
          title: 'Upload image',
        ),
        if (getVideo)
          CupertinoAction(
            onTap: () => ImagePickerHandler.onGetVideo().then((values) {
              if (values != null) {
                getImages?.call([values]);
              }
            }),
            title: 'Upload video',
          ),
      ],
    );
  }

  static Future<Size> getImageSize(File file) async {
    var decodedImage = await decodeImageFromList(file.readAsBytesSync());
    return Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
  }
}
