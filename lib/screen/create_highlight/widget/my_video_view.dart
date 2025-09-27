import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/service/photo_gallery_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_cubit.dart';
import 'package:flutter_bump_app/widget/extension/widget_extension.dart';
import 'package:photo_manager/photo_manager.dart';

import '../create_highlight_state.dart';

class MyVideoView extends StatelessWidget {
  const MyVideoView(
      {super.key, this.item, required this.state, required this.cubit});

  final PhotoMediaAsset? item;
  final CreateHighlightCubit cubit;
  final CreateHighlightState state;

  @override
  Widget build(BuildContext context) {
    final isSelected = state.isVideoSelected(item?.assetEntity.id ?? '');
    final selectionNumber =
        state.getSelectionNumber(item?.assetEntity.id ?? '');

    return GestureDetector(
      onTap: item != null ? () => cubit.toggleVideoSelection(item!) : null,
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.alpha,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? appTheme.blue500 : appTheme.gray200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: appTheme.blue200.withSafeOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: appTheme.gray200.withSafeOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with selection indicator
            SizedBox(
              width: double.infinity,
              height: 138.h,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildThumbnail(item))),
                  Center(
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: appTheme.alpha.withSafeOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: appTheme.gray600,
                        size: 18,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: isSelected ? appTheme.blue500 : appTheme.alpha,
                        border: Border.all(
                          color:
                              isSelected ? appTheme.blue500 : appTheme.gray300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isSelected
                          ? Center(
                              child: Text(
                                '$selectionNumber',
                                style:
                                    AppStyle.regular12(color: appTheme.alpha),
                              ),
                            )
                          : null,
                    ),
                  ),

                  // Duration
                  Positioned(
                    bottom: 4.h,
                    right: 4.w,
                    child: Container(
                      padding: padding(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: appTheme.blackColor.withSafeOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${item?.assetEntity.duration}',
                        style: AppStyle.regular12(color: appTheme.alpha),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Title
            FutureBuilder(
              future: item?.assetEntity.titleAsync,
              builder: (context, snapshot) {
                return Text(snapshot.data ?? '',
                    style: AppStyle.medium14(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis);
              },
            ).space(all: 8)
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(PhotoMediaAsset? item) {
    if (item?.assetEntity.type == AssetType.video) {
      if (item?.imageFile != null) {
        return Image.file(item!.imageFile!, fit: BoxFit.cover);
      } else {
        return Image.memory(item!.thumbnailByte!, fit: BoxFit.cover);
      }
    }
    return Container();
  }
}
