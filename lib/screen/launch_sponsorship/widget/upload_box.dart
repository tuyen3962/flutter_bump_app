import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/launch_sponsorship_cubit.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/launch_sponsorship_state.dart';
import 'package:flutter_bump_app/utils/image_picker_handler.dart';
import 'package:flutter_bump_app/widget/extension/widget_extension.dart';
import 'package:flutter_bump_app/widget/image/custom_image.dart';

class UploadBox extends StatelessWidget {
  const UploadBox({super.key, required this.type});

  final UploadBannerType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchSponsorshipCubit, LaunchSponsorshipState>(
      builder: (context, state) {
        final file = type == UploadBannerType.logo ? state.logo : state.banner;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  type == UploadBannerType.logo ? 'Logo' : 'Banner',
                  style: AppStyle.medium12(color: appTheme.whiteText),
                ),
                if (type == UploadBannerType.logo)
                  Text(
                    ' *',
                    style: AppStyle.medium12(color: Colors.red),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            if (file != null)
              CustomImage(
                  imageFile: file,
                  width: double.infinity,
                  height: 100.h,
                  boxFit: BoxFit.cover,
                  radius: 8)
            else
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF374151),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withSafeOpacity(0.2),
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: appTheme.green4AColor,
                        size: 24.w,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Click to upload',
                        style: AppStyle.regular10(color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    ).clickable(onTap: () {
      ImagePickerHandler.onGetImage().then((value) {
        if (value != null) {
          context
              .read<LaunchSponsorshipCubit>()
              .updateUploadBanner(value, type);
        }
      });
    });
  }
}
