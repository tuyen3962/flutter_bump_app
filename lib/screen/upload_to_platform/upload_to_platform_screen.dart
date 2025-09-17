import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/upload_to_platform/upload_to_platform_cubit.dart';
import 'package:flutter_bump_app/screen/upload_to_platform/upload_to_platform_parameter.dart';

import 'upload_to_platform_state.dart';

@RoutePage()
class UploadToPlatformPage extends BaseBlocProvider<UploadToPlatformState, UploadToPlatformCubit> {
  final UploadToPlatformParameter platformParam;

  const UploadToPlatformPage({super.key, required this.platformParam});

  @override
  Widget buildPage() {
    return UploadToPlatformScreen(platformParam: platformParam);
  }

  @override
  UploadToPlatformCubit createCubit() {
    return UploadToPlatformCubit();
  }
}

class UploadToPlatformScreen extends StatefulWidget {
  final UploadToPlatformParameter platformParam;

  const UploadToPlatformScreen({super.key, required this.platformParam});

  @override
  State<UploadToPlatformScreen> createState() => UploadToPlatformScreenState();
}

class UploadToPlatformScreenState
    extends BaseBlocNoAppBarPageState<UploadToPlatformScreen, UploadToPlatformState, UploadToPlatformCubit> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize platform based on parameter
      final platform = widget.platformParam.platform == PlatformType.tiktok ? Platform.tiktok : Platform.youtube;
      cubit.initializePlatform(platform);
      _updateControllers();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  String get title => 'Upload to Platform';

  void _updateControllers() {
    final state = cubit.state;
    if (_titleController.text != state.title) {
      _titleController.text = state.title;
    }
    if (_descriptionController.text != state.description) {
      _descriptionController.text = state.description;
    }
    if (_tagsController.text != state.tags) {
      _tagsController.text = state.tags;
    }
  }

  @override
  Widget buildBody(BuildContext context, UploadToPlatformCubit cubit) {
    return BlocListener<UploadToPlatformCubit, UploadToPlatformState>(
      listener: (context, state) {
        _updateControllers();
      },
      child: BlocBuilder<UploadToPlatformCubit, UploadToPlatformState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appTheme.alpha,
            body: Column(
              children: [
                // Header
                _buildHeader(state),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: padding(all: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Video Preview
                        _buildVideoPreview(),

                        SizedBox(height: 24.h),

                        // Title Field
                        _buildTitleField(state),

                        SizedBox(height: 24.h),

                        // Description Field
                        _buildDescriptionField(state),

                        SizedBox(height: 24.h),

                        // Thumbnail Section
                        _buildThumbnailSection(),

                        SizedBox(height: 24.h),

                        // Visibility Section
                        _buildVisibilitySection(state),

                        // YouTube Specific Fields
                        if (state.showYouTubeSpecificFields) ...[
                          SizedBox(height: 24.h),
                          _buildCategoryField(state),
                          SizedBox(height: 24.h),
                          _buildTagsField(state),
                        ],

                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),

                // Upload Progress (if uploading)
                if (state.isUploading) _buildUploadProgress(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(UploadToPlatformState state) {
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
                'Upload to ${state.platformName}',
                style: AppStyle.bold18(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 36.h,
              child: ElevatedButton(
                onPressed: state.isFormValid && !state.isUploading ? _handlePublish : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.isFormValid && !state.isUploading ? appTheme.blue500 : appTheme.gray300,
                  foregroundColor: appTheme.alpha,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                child: state.isUploading
                    ? SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(appTheme.alpha),
                        ),
                      )
                    : Text(
                        'Publish',
                        style: AppStyle.medium14(color: appTheme.alpha),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPreview() {
    return Container(
      width: double.infinity,
      height: 192.h,
      decoration: BoxDecoration(
        color: appTheme.gray900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: appTheme.alpha,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(
                Icons.play_arrow,
                size: 32,
                color: appTheme.gray900,
              ),
            ),
          ),
          Positioned(
            bottom: 8.h,
            right: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.blackColor.withSafeOpacity(0.75),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '3:00',
                style: AppStyle.regular14(color: appTheme.alpha),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField(UploadToPlatformState state) {
    final hasError = state.title.trim().isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Title ',
                style: AppStyle.medium14(color: appTheme.gray900),
              ),
              TextSpan(
                text: '*',
                style: AppStyle.medium14(color: appTheme.red500),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Stack(
          children: [
            TextFormField(
              controller: _titleController,
              onChanged: cubit.updateTitle,
              maxLength: state.titleMaxLength,
              style: AppStyle.regular14(),
              decoration: InputDecoration(
                hintText: 'Enter ${state.platformName} title...',
                hintStyle: AppStyle.regular14(color: appTheme.gray400),
                filled: true,
                fillColor: appTheme.gray50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: hasError ? appTheme.red300 : appTheme.gray300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: hasError ? appTheme.red300 : appTheme.gray300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: hasError ? appTheme.red500 : appTheme.blue500,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                counterText: '', // Hide default counter
              ),
            ),
            Positioned(
              bottom: 8.h,
              right: 12.w,
              child: Text(
                '${state.title.length}/${state.titleMaxLength}',
                style: AppStyle.regular12(color: appTheme.gray400),
              ),
            ),
          ],
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              'Title is required',
              style: AppStyle.regular12(color: appTheme.red500),
            ),
          ),
      ],
    );
  }

  Widget _buildDescriptionField(UploadToPlatformState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppStyle.medium14(color: appTheme.gray900),
        ),
        SizedBox(height: 8.h),
        Stack(
          children: [
            TextFormField(
              controller: _descriptionController,
              onChanged: cubit.updateDescription,
              maxLines: 4,
              maxLength: state.descriptionMaxLength,
              style: AppStyle.regular14(),
              decoration: InputDecoration(
                hintText: 'Enter ${state.platformName} description...',
                hintStyle: AppStyle.regular14(color: appTheme.gray400),
                filled: true,
                fillColor: appTheme.gray50,
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
                  vertical: 12.h,
                ),
                counterText: '', // Hide default counter
              ),
            ),
            Positioned(
              bottom: 8.h,
              right: 12.w,
              child: Text(
                '${state.description.length}/${state.descriptionMaxLength}',
                style: AppStyle.regular12(color: appTheme.gray400),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThumbnailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thumbnail',
          style: AppStyle.medium14(color: appTheme.gray900),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 128.h,
          decoration: BoxDecoration(
            color: appTheme.gray900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: appTheme.alpha,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.play_arrow,
                size: 24,
                color: appTheme.gray900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisibilitySection(UploadToPlatformState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visibility',
          style: AppStyle.medium14(color: appTheme.gray900),
        ),
        SizedBox(height: 12.h),
        Column(
          children: cubit.availableVisibilities.map((visibility) {
            final isSelected = state.visibility == visibility;
            final visibilityText = _getVisibilityText(visibility);

            return GestureDetector(
              onTap: () => cubit.updateVisibility(visibility),
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Container(
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
                          ? Icon(
                              Icons.check,
                              size: 12,
                              color: appTheme.alpha,
                            )
                          : null,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      visibilityText,
                      style: AppStyle.regular14(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryField(UploadToPlatformState state) {
    final hasError = state.category.trim().isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppStyle.medium14(color: appTheme.gray900),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: state.category.isEmpty ? null : state.category,
          onChanged: (value) => cubit.updateCategory(value ?? ''),
          style: AppStyle.regular14(),
          decoration: InputDecoration(
            filled: true,
            fillColor: appTheme.gray50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? appTheme.red300 : appTheme.gray300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? appTheme.red300 : appTheme.gray300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? appTheme.red500 : appTheme.blue500,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
          hint: Text(
            'Select a category',
            style: AppStyle.regular14(color: appTheme.gray400),
          ),
          items: cubit.availableCategories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              'Category is required for YouTube',
              style: AppStyle.regular12(color: appTheme.red500),
            ),
          ),
      ],
    );
  }

  Widget _buildTagsField(UploadToPlatformState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: AppStyle.medium14(color: appTheme.gray900),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _tagsController,
          onChanged: cubit.updateTags,
          style: AppStyle.regular14(),
          decoration: InputDecoration(
            hintText: 'basketball, highlights, sports, game...',
            hintStyle: AppStyle.regular14(color: appTheme.gray400),
            filled: true,
            fillColor: appTheme.gray50,
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
              vertical: 12.h,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Separate tags with commas',
          style: AppStyle.regular12(color: appTheme.gray500),
        ),
      ],
    );
  }

  Widget _buildUploadProgress(UploadToPlatformState state) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          top: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Uploading to ${state.platformName}...',
                style: AppStyle.medium14(),
              ),
              Text(
                '${(state.uploadProgress * 100).round()}%',
                style: AppStyle.medium14(color: appTheme.blue500),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: state.uploadProgress,
            backgroundColor: appTheme.gray200,
            valueColor: AlwaysStoppedAnimation<Color>(appTheme.blue500),
          ),
        ],
      ),
    );
  }

  String _getVisibilityText(Visibilitys visibility) {
    switch (visibility) {
      case Visibilitys.public:
        return 'Public';
      case Visibilitys.unlisted:
        return 'Unlisted';
      case Visibilitys.private:
        return 'Private';
    }
  }

  void _handlePublish() async {
    final validationError = cubit.validateForm();
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            validationError,
            style: AppStyle.medium14(color: appTheme.alpha),
          ),
          backgroundColor: appTheme.red500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
      return;
    }

    final success = await cubit.publishVideo();
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Successfully uploaded to ${cubit.state.platformName}!',
            style: AppStyle.medium14(color: appTheme.alpha),
          ),
          backgroundColor: appTheme.green500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(16),
        ),
      );

      // Navigate back to player after successful upload
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          context.back();
        }
      });
    } else if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to upload. Please try again.',
            style: AppStyle.medium14(color: appTheme.alpha),
          ),
          backgroundColor: appTheme.red500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
    }
  }
}
