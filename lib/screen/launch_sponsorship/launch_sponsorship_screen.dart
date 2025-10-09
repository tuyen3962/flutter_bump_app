import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/launch_sponsorship_cubit.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/launch_sponsorship_parameter.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/widget/upload_box.dart';

import 'launch_sponsorship_state.dart';

@RoutePage()
class LaunchSponsorshipPage
    extends BaseBlocProvider<LaunchSponsorshipState, LaunchSponsorshipCubit> {
  const LaunchSponsorshipPage({super.key, required this.parameter});

  final LaunchSponsorshipParameter parameter;

  @override
  Widget buildPage() {
    return LaunchSponsorshipScreen(parameter: parameter);
  }

  @override
  LaunchSponsorshipCubit createCubit() {
    return LaunchSponsorshipCubit(
        campaign: parameter.campaign, updateCampaignUsecase: locator.get());
  }
}

class LaunchSponsorshipScreen extends StatefulWidget {
  const LaunchSponsorshipScreen({super.key, required this.parameter});

  final LaunchSponsorshipParameter parameter;

  @override
  State<LaunchSponsorshipScreen> createState() =>
      LaunchSponsorshipScreenState();
}

class LaunchSponsorshipScreenState extends BaseBlocNoAppBarPageState<
    LaunchSponsorshipScreen, LaunchSponsorshipState, LaunchSponsorshipCubit> {
  final TextEditingController _channelNameController = TextEditingController();
  final TextEditingController _channelDescController = TextEditingController();
  final TextEditingController _campaignBriefController =
      TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
  final TextEditingController _telegramController = TextEditingController();
  final TextEditingController _discordController = TextEditingController();

  @override
  bool get isSafeArea => false;

  @override
  void initState() {
    super.initState();
    if (widget.parameter.fillInfo) {
      // _channelNameController.text =
      //     widget.parameter.campaign.creator?.name ?? '';
    }
  }

  @override
  void dispose() {
    _channelNameController.dispose();
    _channelDescController.dispose();
    _campaignBriefController.dispose();
    _websiteController.dispose();
    _twitterController.dispose();
    _telegramController.dispose();
    _discordController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context, LaunchSponsorshipCubit cubit) {
    return BlocConsumer<LaunchSponsorshipCubit, LaunchSponsorshipState>(
      listener: (context, state) {
        if (state.campaign != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '🚀 Campaign launched successfully!',
                style: AppStyle.medium14(
                  color: appTheme.whiteText,
                ),
              ),
              backgroundColor: appTheme.green4AColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
          context.back();
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0F172A),
                Color(0xFF1E293B),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(state, cubit),
                Expanded(
                  child: SingleChildScrollView(
                    padding: padding(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      children: [
                        if (state.currentStep == 1) _buildStep1(state, cubit),
                        if (state.currentStep == 2) _buildStep2(state, cubit),
                      ],
                    ),
                  ),
                ),
                _buildBottomNavigation(state, cubit),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
      LaunchSponsorshipState state, LaunchSponsorshipCubit cubit) {
    return Container(
      padding: padding(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.back(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withSafeOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: appTheme.whiteText,
                    size: 20.w,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                'Launch Sponsorship',
                style: AppStyle.bold20(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Step indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepIndicator(1, state.currentStep, cubit),
              Container(
                width: 40.w,
                height: 2.h,
                color: state.currentStep >= 2
                    ? appTheme.green4AColor
                    : Colors.white.withSafeOpacity(0.2),
              ),
              _buildStepIndicator(2, state.currentStep, cubit),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Step ${state.currentStep} of 2: ${state.currentStep == 1 ? "Block Setup" : "Requirements & Launch"}',
            style: AppStyle.medium12(color: Colors.white60),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(
      int step, int currentStep, LaunchSponsorshipCubit cubit) {
    final isActive = step <= currentStep;
    final isCurrent = step == currentStep;

    return GestureDetector(
      onTap: () {
        if (step < currentStep) {
          cubit.goToStep(step);
        }
      },
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: isActive
              ? appTheme.green4AColor
              : Colors.white.withSafeOpacity(0.1),
          shape: BoxShape.circle,
          border: isCurrent
              ? Border.all(
                  color: appTheme.green4AColor,
                  width: 2,
                )
              : null,
        ),
        child: Center(
          child: Text(
            '$step',
            style: AppStyle.bold14(
              color: isActive ? const Color(0xFF0F172A) : Colors.white60,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1(
      LaunchSponsorshipState state, LaunchSponsorshipCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overview card
        _buildOverviewCard(state),
        SizedBox(height: 16.h),

        // Channel Information
        _buildSectionCard(
          icon: Icons.upload_file,
          title: 'Channel Information',
          children: [
            _buildTextField(
              'Channel Name',
              _channelNameController,
              'Your brand/project name',
              isRequired: true,
              onChanged: (value) => cubit.updateChannelName(value),
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              'Channel Description',
              _channelDescController,
              'Brief description of your project/brand',
              isRequired: true,
              maxLines: 3,
              onChanged: (value) => cubit.updateChannelDesc(value),
            ),
            SizedBox(height: 16.h),
            // Logo & Banner upload
            Row(
              children: [
                Expanded(
                  // child: _buildUploadBox('Logo', true, UploadBannerType.logo),
                  child: UploadBox(type: UploadBannerType.logo),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: UploadBox(type: UploadBannerType.banner),
                  // _buildUploadBox('Banner', false, UploadBannerType.banner),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Social Links
        _buildSectionCard(
          icon: Icons.link,
          title: 'Social Links',
          children: [
            _buildTextField(
              'Website',
              _websiteController,
              'https://yourproject.com',
              onChanged: (value) => cubit.updateWebsite(value),
            ),
            SizedBox(height: 12.h),
            _buildTextField(
              'Twitter/X',
              _twitterController,
              '@yourbrand',
              onChanged: (value) => cubit.updateTwitter(value),
            ),
            SizedBox(height: 12.h),
            _buildTextField(
              'Telegram',
              _telegramController,
              '@yourbrand',
              onChanged: (value) => cubit.updateTelegram(value),
            ),
            SizedBox(height: 12.h),
            _buildTextField(
              'Discord',
              _discordController,
              'discord.gg/yourbrand',
              onChanged: (value) => cubit.updateDiscord(value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2(
      LaunchSponsorshipState state, LaunchSponsorshipCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Requirements card
        _buildSectionCard(
          icon: Icons.gps_fixed,
          title: 'Video Requirements',
          children: [
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.black.withSafeOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64.w,
                      height: 64.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withSafeOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: appTheme.whiteText,
                        size: 32.w,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Demo Video Preview',
                      style: AppStyle.regular12(color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Select requirements for the creator to fulfill in their video content',
              style: AppStyle.regular12(color: Colors.white60),
            ),
            SizedBox(height: 16.h),
            ...state.availableRequirements.map((req) {
              final isSelected = state.selectedRequirements.contains(req['id']);
              return GestureDetector(
                onTap: () => cubit.toggleRequirement(req['id'] as String),
                child: Container(
                  margin: padding(bottom: 12.h),
                  padding: padding(all: 12.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? appTheme.green4AColor.withSafeOpacity(0.1)
                        : Colors.white.withSafeOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? appTheme.green4AColor
                          : Colors.white.withSafeOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? appTheme.green4AColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: isSelected
                                ? appTheme.green4AColor
                                : Colors.white.withSafeOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                color: const Color(0xFF0F172A),
                                size: 14.w,
                              )
                            : null,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          req['label'] as String,
                          style: AppStyle.regular14(
                            color: appTheme.whiteText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewCard(LaunchSponsorshipState state) {
    return Container(
      padding: padding(all: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.gps_fixed,
                color: appTheme.green4AColor,
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Overview',
                style: AppStyle.bold14(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildOverviewRow(
              'Creator', widget.parameter.campaign.creator?.name ?? ''),
          SizedBox(height: 8.h),
          _buildOverviewRow(
            'Duration',
            '${DateTime.now().toString().split(' ')[0]} → ${DateTime.now().add(const Duration(days: 14)).toString().split(' ')[0]}',
          ),
          SizedBox(height: 8.h),
          _buildOverviewRow(
            'Total Cost',
            '${widget.parameter.campaign.budget?.toStringAsFixed(1) ?? '0.0'} SOL',
            isHighlight: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewRow(String label, String value,
      {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyle.regular12(color: Colors.white60),
        ),
        Text(
          value,
          style: AppStyle.bold12(
            color: isHighlight ? appTheme.green4AColor : appTheme.whiteText,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: padding(all: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: appTheme.green4AColor,
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppStyle.bold14(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint, {
    bool isRequired = false,
    int maxLines = 1,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppStyle.medium12(color: appTheme.whiteText),
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppStyle.medium12(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: AppStyle.regular14(color: appTheme.whiteText),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppStyle.regular14(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF374151),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: padding(horizontal: 12.w, vertical: 12.h),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(
      LaunchSponsorshipState state, LaunchSponsorshipCubit cubit) {
    return Container(
      padding: padding(all: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        border: Border(
          top: BorderSide(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (state.currentStep > 1)
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () => cubit.previousStep(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF374151),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: appTheme.whiteText,
                        size: 20.w,
                      ),
                      Text(
                        'Previous',
                        style: AppStyle.bold14(color: appTheme.whiteText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (state.currentStep > 1) SizedBox(width: 12.w),
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: state.canProceed
                    ? () {
                        if (state.currentStep < 2) {
                          cubit.nextStep();
                        } else {
                          cubit.launchCampaign();
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appTheme.transparentColor,
                  disabledBackgroundColor: Colors.grey.shade800,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: state.canProceed
                        ? LinearGradient(
                            colors: [
                              appTheme.green4AColor,
                              appTheme.green69Color,
                            ],
                          )
                        : null,
                    color: state.canProceed ? null : Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.currentStep == 2)
                          Icon(
                            Icons.rocket_launch,
                            color: state.canProceed
                                ? const Color(0xFF0F172A)
                                : Colors.white38,
                            size: 20.w,
                          ),
                        if (state.currentStep == 2) SizedBox(width: 8.w),
                        Text(
                          state.currentStep < 2 ? 'Next' : 'Launch Sponsorship',
                          style: AppStyle.bold14(
                            color: state.canProceed
                                ? const Color(0xFF0F172A)
                                : Colors.white38,
                          ),
                        ),
                        if (state.currentStep < 2)
                          Icon(
                            Icons.chevron_right,
                            color: state.canProceed
                                ? const Color(0xFF0F172A)
                                : Colors.white38,
                            size: 20.w,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
