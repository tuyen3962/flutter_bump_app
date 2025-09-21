import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/stream/base_stream_builder.dart';
import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';
import 'package:flutter_bump_app/main.dart';

class UploadingVideoLoading extends StatefulWidget {
  const UploadingVideoLoading({super.key, required this.uploadProgress});

  final BaseStreamController<double> uploadProgress;
  static Future<void> showUploadingDialog(BuildContext context,
      {required BaseStreamController<double> uploadProgress}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return UploadingVideoLoading(uploadProgress: uploadProgress);
      },
    );
  }

  @override
  State<UploadingVideoLoading> createState() => _UploadingVideoLoadingState();
}

class _UploadingVideoLoadingState extends State<UploadingVideoLoading>
    with TickerProviderStateMixin {
  late final StreamSubscription<double> _uploadProgressSubscription;

  @override
  void initState() {
    super.initState();
    _uploadProgressSubscription =
        widget.uploadProgress.stream.listen((progress) {
      if (progress == 100) {
        print('end');
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _uploadProgressSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: appTheme.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: appTheme.alpha,
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(children: [
              Icon(Icons.cloud_upload_outlined,
                  color: appTheme.primaryColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Uploading Video',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 24),

            // Progress Circle
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                children: [
                  // Background circle
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 8,
                      backgroundColor: appTheme.background,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          appTheme.backgroundContainer),
                    ),
                  ),
                  // Progress circle
                  BaseStreamBuilder<double>(
                    controller: widget.uploadProgress,
                    builder: (value) => SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: value / 100,
                        strokeWidth: 8,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.uploadProgress.value == 100
                              ? appTheme.primaryColor
                              : appTheme.green400,
                        ),
                      ),
                    ),
                  ),
                  // Center content
                  Positioned.fill(
                    child: BaseStreamBuilder<double>(
                      controller: widget.uploadProgress,
                      builder: (value) => Center(
                        child: value == 100
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${value.toInt()}%',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: appTheme.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    'Uploading',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: appTheme.primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            : Icon(
                                Icons.check,
                                color: appTheme.green400,
                                size: 32,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
