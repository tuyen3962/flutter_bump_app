import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_cubit.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_state.dart';
import 'package:flutter_bump_app/utils/lazy_list/lazy_list.dart';
import 'package:flutter_bump_app/widget/extension/widget_extension.dart';

import 'widget/enter_name_highlight_dialog.dart';
import 'widget/my_video_view.dart';

@RoutePage()
class CreateHighlightPage
    extends BaseBlocProvider<CreateHighlightState, CreateHighlightCubit> {
  const CreateHighlightPage({super.key});

  @override
  Widget buildPage() {
    return const CreateHighlightScreen();
  }

  @override
  CreateHighlightCubit createCubit() {
    return CreateHighlightCubit();
  }
}

class CreateHighlightScreen extends StatefulWidget {
  const CreateHighlightScreen({super.key});

  @override
  State<CreateHighlightScreen> createState() => CreateHighlightScreenState();
}

class CreateHighlightScreenState extends BaseBlocNoAppBarPageState<
    CreateHighlightScreen, CreateHighlightState, CreateHighlightCubit> {
  @override
  String get title => 'Create Highlight';

  @override
  Widget buildBody(BuildContext context, CreateHighlightCubit cubit) {
    return BlocBuilder<CreateHighlightCubit, CreateHighlightState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.alpha,
          body: Column(
            children: [
              // Header
              _buildHeader(),

              // File Format Info
              _buildFileFormatInfo(),

              // Record/Upload Toggle
              // _buildModeToggle(state),

              // Library Header
              _buildLibraryHeader(state),

              // Video Grid
              LazyListView(
                listPadding: padding(horizontal: 16, vertical: 8),
                itemBuilder: (index, item) =>
                    MyVideoView(item: item, state: state, cubit: cubit),
                controller: cubit.photoGalleryService.mediaListCtrl,
                shrinkWrap: false,
                lineItemCount: 2,
                paddingBetweenItem: 8,
                paddingBetweenLine: 8,
                skeletonView: () {
                  return const SizedBox();
                },
              ).expand(),

              AnimatedCrossFade(
                crossFadeState: state.hasSelectedVideos
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _buildCreateButton(state),
                secondChild: const SizedBox(),
                duration: const Duration(milliseconds: 300),
                firstCurve: Curves.easeInOut,
                secondCurve: Curves.easeInOut,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.back(),
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: appTheme.transparentColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: appTheme.gray600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Create Highlight',
                style: AppStyle.bold18(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 32.w),
          ],
        ),
      ),
    );
  }

  Widget _buildFileFormatInfo() {
    return Container(
      width: double.infinity,
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.blue50,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Supported formats: ',
                  style: AppStyle.bold14(color: appTheme.blue800),
                ),
                TextSpan(
                  text: 'MP4, MOV, AVI',
                  style: AppStyle.regular14(color: appTheme.blue800),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Maximum file size: 1GB',
            style: AppStyle.regular14(color: appTheme.blue600),
          ),
        ],
      ),
    );
  }

  // Widget _buildModeToggle(CreateHighlightState state) {
  //   return Container(
  //     padding: padding(all: 16),
  //     decoration: BoxDecoration(
  //       color: appTheme.gray50,
  //       border: Border(
  //         bottom: BorderSide(color: appTheme.gray200, width: 1),
  //       ),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () => cubit.setActiveMode(CreateMode.record),
  //             child: Container(
  //               padding: padding(all: 12),
  //               margin: padding(right: 8.w),
  //               decoration: BoxDecoration(
  //                 color: state.activeMode == CreateMode.record
  //                     ? appTheme.blue500
  //                     : appTheme.alpha,
  //                 border: Border.all(
  //                   color: state.activeMode == CreateMode.record
  //                       ? appTheme.blue500
  //                       : appTheme.gray200,
  //                   width: 2,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Icon(
  //                     Icons.videocam,
  //                     size: 18,
  //                     color: state.activeMode == CreateMode.record
  //                         ? appTheme.alpha
  //                         : appTheme.gray700,
  //                   ),
  //                   SizedBox(width: 8.w),
  //                   Text(
  //                     'Record',
  //                     style: AppStyle.medium16(
  //                       color: state.activeMode == CreateMode.record
  //                           ? appTheme.alpha
  //                           : appTheme.gray700,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () async {
  //               final image = await ImagePickerHandler.onGetVideo();
  //               if (image != null) {
  //                 UploadingVideoLoading.showUploadingDialog(context,
  //                     uploadProgress: cubit.uploadProgress);
  //                 await cubit.uploadVideo(image);
  //               }
  //             },
  //             child: Container(
  //               padding: padding(all: 12),
  //               margin: padding(left: 8.w),
  //               decoration: BoxDecoration(
  //                 color: state.activeMode == CreateMode.upload
  //                     ? appTheme.blue500
  //                     : appTheme.alpha,
  //                 border: Border.all(
  //                   color: state.activeMode == CreateMode.upload
  //                       ? appTheme.blue500
  //                       : appTheme.gray200,
  //                   width: 2,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Icon(
  //                     Icons.upload,
  //                     size: 18,
  //                     color: state.activeMode == CreateMode.upload
  //                         ? appTheme.alpha
  //                         : appTheme.gray700,
  //                   ),
  //                   SizedBox(width: 8.w),
  //                   Text(
  //                     'Upload',
  //                     style: AppStyle.medium16(
  //                       color: state.activeMode == CreateMode.upload
  //                           ? appTheme.alpha
  //                           : appTheme.gray700,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLibraryHeader(CreateHighlightState state) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Your Video Library',
            style: AppStyle.medium16(),
          ),
          if (state.hasSelectedVideos)
            Text(
              '${state.selectedCount} selected',
              style: AppStyle.regular14(color: appTheme.blue600),
            ),
        ],
      ),
    );
  }

  // Widget _buildVideoGrid(CreateHighlightState state) {
  // if (state.isLoading) {
  //   return Center(
  //     child: CircularProgressIndicator(
  //       color: appTheme.blue500,
  //     ),
  //   );
  // }

  // if (state.libraryItems.isEmpty) {
  //   return _buildEmptyState();
  // }

  // return RefreshIndicator(
  //   onRefresh: cubit.refreshLibrary,
  //   color: appTheme.blue500,
  //   child: GridView.builder(
  //     padding: padding(all: 16),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       childAspectRatio: 0.8,
  //       crossAxisSpacing: 12,
  //       mainAxisSpacing: 12,
  //     ),
  //     itemCount: state.libraryItems.length,
  //     itemBuilder: (context, index) {
  //       final item = state.libraryItems[index];
  //       return _buildVideoItem(item, state);
  //     },
  //   ),
  // );
  // }

  Widget _buildCreateButton(CreateHighlightState state) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          top: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: () => EnterNameHighlightDialog.show(context,
              onHighlightNameChanged: cubit.updateHighlightName),
          style: ElevatedButton.styleFrom(
            backgroundColor: appTheme.blue500,
            foregroundColor: appTheme.alpha,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            'Create Highlight (${state.selectedCount} video${state.selectedCount > 1 ? 's' : ''})',
            style: AppStyle.medium16(color: appTheme.alpha),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: padding(all: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: appTheme.gray200,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(
                Icons.videocam,
                size: 24,
                color: appTheme.gray400,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No videos yet',
              style: AppStyle.bold18(),
            ),
            SizedBox(height: 8.h),
            Text(
              'Record or upload your first pickleball video to create highlights',
              style: AppStyle.regular14(color: appTheme.gray500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
