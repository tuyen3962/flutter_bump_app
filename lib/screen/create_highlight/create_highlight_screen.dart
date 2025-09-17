import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_cubit.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_state.dart';

@RoutePage()
class CreateHighlightPage extends BaseBlocProvider<CreateHighlightState, CreateHighlightCubit> {
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

class CreateHighlightScreenState
    extends BaseBlocNoAppBarPageState<CreateHighlightScreen, CreateHighlightState, CreateHighlightCubit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeLibrary();
    });
  }

  @override
  String get title => 'Create Highlight';

  @override
  Widget buildBody(BuildContext context, CreateHighlightCubit cubit) {
    return BlocBuilder<CreateHighlightCubit, CreateHighlightState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: appTheme.alpha,
              body: Column(
                children: [
                  // Header
                  _buildHeader(),

                  // File Format Info
                  _buildFileFormatInfo(),

                  // Record/Upload Toggle
                  _buildModeToggle(state),

                  // Library Header
                  _buildLibraryHeader(state),

                  // Video Grid
                  Expanded(
                    child: _buildVideoGrid(state),
                  ),

                  // Create Highlight Button
                  if (state.hasSelectedVideos) _buildCreateButton(state),
                ],
              ),
            ),

            // Name Dialog Overlay
            if (state.showNameDialog) _buildNameDialog(state),
          ],
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

  Widget _buildModeToggle(CreateHighlightState state) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.gray50,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => cubit.setActiveMode(CreateMode.record),
              child: Container(
                padding: padding(all: 12),
                margin: padding(right: 8.w),
                decoration: BoxDecoration(
                  color: state.activeMode == CreateMode.record ? appTheme.blue500 : appTheme.alpha,
                  border: Border.all(
                    color: state.activeMode == CreateMode.record ? appTheme.blue500 : appTheme.gray200,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.videocam,
                      size: 18,
                      color: state.activeMode == CreateMode.record ? appTheme.alpha : appTheme.gray700,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Record',
                      style: AppStyle.medium16(
                        color: state.activeMode == CreateMode.record ? appTheme.alpha : appTheme.gray700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => cubit.setActiveMode(CreateMode.upload),
              child: Container(
                padding: padding(all: 12),
                margin: padding(left: 8.w),
                decoration: BoxDecoration(
                  color: state.activeMode == CreateMode.upload ? appTheme.blue500 : appTheme.alpha,
                  border: Border.all(
                    color: state.activeMode == CreateMode.upload ? appTheme.blue500 : appTheme.gray200,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload,
                      size: 18,
                      color: state.activeMode == CreateMode.upload ? appTheme.alpha : appTheme.gray700,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Upload',
                      style: AppStyle.medium16(
                        color: state.activeMode == CreateMode.upload ? appTheme.alpha : appTheme.gray700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildVideoGrid(CreateHighlightState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: appTheme.blue500,
        ),
      );
    }

    if (state.libraryItems.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: cubit.refreshLibrary,
      color: appTheme.blue500,
      child: GridView.builder(
        padding: padding(all: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: state.libraryItems.length,
        itemBuilder: (context, index) {
          final item = state.libraryItems[index];
          return _buildVideoItem(item, state);
        },
      ),
    );
  }

  Widget _buildVideoItem(LibraryItem item, CreateHighlightState state) {
    final isSelected = state.isVideoSelected(item.id);
    final selectionNumber = state.getSelectionNumber(item.id);

    return GestureDetector(
      onTap: () => cubit.toggleVideoSelection(item.id),
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
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _getColorFromHex(item.thumbnail),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: Center(
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
                  ),

                  // Selection indicator
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: isSelected ? appTheme.blue500 : appTheme.alpha,
                        border: Border.all(
                          color: isSelected ? appTheme.blue500 : appTheme.gray300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isSelected
                          ? Center(
                              child: Text(
                                '$selectionNumber',
                                style: AppStyle.regular12(color: appTheme.alpha),
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
                        item.duration,
                        style: AppStyle.regular12(color: appTheme.alpha),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Title
            Padding(
              padding: padding(all: 8),
              child: Text(
                item.title,
                style: AppStyle.medium14(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          onPressed: cubit.showNameDialog,
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

  Widget _buildNameDialog(CreateHighlightState state) {
    return Container(
      color: appTheme.blackColor.withSafeOpacity(0.5),
      child: Center(
        child: Container(
          margin: padding(all: 16),
          padding: padding(all: 24),
          decoration: BoxDecoration(
            color: appTheme.alpha,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name Your Highlight',
                    style: AppStyle.bold18(),
                  ),
                  GestureDetector(
                    onTap: cubit.hideNameDialog,
                    child: Container(
                      padding: padding(all: 4),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: appTheme.gray400,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Highlight Name',
                    style: AppStyle.medium14(color: appTheme.gray700),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    initialValue: state.highlightName,
                    onChanged: cubit.updateHighlightName,
                    autofocus: true,
                    style: AppStyle.regular16(),
                    decoration: InputDecoration(
                      hintText: 'Enter highlight name...',
                      hintStyle: AppStyle.regular16(color: appTheme.gray400),
                      filled: true,
                      fillColor: appTheme.alpha,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: appTheme.gray300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: appTheme.gray300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: appTheme.blue500, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: cubit.hideNameDialog,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: appTheme.gray700,
                          side: BorderSide(color: appTheme.gray300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppStyle.medium16(color: appTheme.gray700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: state.highlightName.trim().isNotEmpty
                            ? () async {
                                final success = await cubit.createHighlight();
                                if (success && mounted) {
                                  // context.router.pushNamed('/activity');
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.blue500,
                          foregroundColor: appTheme.alpha,
                          disabledBackgroundColor: appTheme.gray300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: state.isLoading
                            ? SizedBox(
                                width: 16.w,
                                height: 16.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(appTheme.alpha),
                                ),
                              )
                            : Text(
                                'Create',
                                style: AppStyle.medium16(color: appTheme.alpha),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorFromHex(String hex) {
    // Convert hex color string to Color
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }
    return Color(int.parse('FF$hex', radix: 16));
  }
}
