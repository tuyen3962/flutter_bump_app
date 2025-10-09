import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/utils/lazy_list/lazy_list_view_skeleton.dart';
import 'package:flutter_bump_app/utils/lazy_list/load_more_view.dart';
import 'package:flutter_bump_app/widget/extension/widget_extension.dart';

import 'sponsorship_tab_cubit.dart';
import 'sponsorship_tab_state.dart';
import 'widget/my_campaign_view.dart';
import 'widget/setup_campaign_view.dart';

class SponsorshipTab extends StatefulWidget {
  const SponsorshipTab({super.key});

  @override
  State<SponsorshipTab> createState() => _SponsorshipTabState();
}

class _SponsorshipTabState extends BaseBlocViewState<SponsorshipTab,
    SponsorshipTabState, SponsorshipTabCubit> {
  @override
  Widget buildView(BuildContext context, SponsorshipTabCubit cubit) {
    return LoadMoreView(
      listPadding: padding(horizontal: 12, top: 16),
      hasRefresh: true,
      onRefresh: cubit.onRefresh,
      onLoadMore: () async {
        // await cubit.setupCampaignsListCtrl.onLoadMore();
      },
      children: [
        LazyListViewSkeleton(
          shrinkWrap: true,
          controller: cubit.setupCampaignsListCtrl,
          skeletonView: () => const SizedBox(),
          physics: const NeverScrollableScrollPhysics(),
          viewPadding: padding(bottom: 24),
          topView: (items) => items.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Setup Required (${items.length})',
                      style: AppStyle.bold18(color: appTheme.green4AColor),
                    ),
                    Container(
                      padding: padding(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: appTheme.green4AColor.withSafeOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: appTheme.green4AColor.withSafeOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'new',
                        style: AppStyle.bold12(color: appTheme.green4AColor),
                      ),
                    ),
                  ],
                ).space(bottom: 16)
              : const SizedBox(),
          itemBuilder: (index, item) => SetupCampaignView(campaign: item),
        ),
        // Your Sponsorships Section
        ValueListenableBuilder(
          valueListenable: cubit.myCampaignsListCtrl.data,
          builder: (context, data, _) => Text(
            'Your Sponsorships (${data.length})',
            style: AppStyle.bold18(color: appTheme.whiteText),
          ),
        ),
        SizedBox(height: 16.h),

        _buildSponsorshipFilterTabs(),
        SizedBox(height: 16.h),

        LazyListViewSkeleton(
          shrinkWrap: true,
          controller: cubit.myCampaignsListCtrl,
          skeletonView: () => const SizedBox(),
          physics: const NeverScrollableScrollPhysics(),
          viewPadding: padding(bottom: 24),
          itemBuilder: (index, item) => MyCampaignView(campaign: item),
        ),
      ],
    );
  }

  Widget _buildSponsorshipFilterTabs() {
    return BlocBuilder<SponsorshipTabCubit, SponsorshipTabState>(
      builder: (context, state) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: SponsorshipTabFilter.values.map((filter) {
            final isSelected = state.filter == filter;
            return Padding(
              padding: padding(right: 8.w),
              child: GestureDetector(
                onTap: () => cubit.selectSponsorshipFilter(filter),
                child: Container(
                  padding: padding(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? appTheme.green4AColor
                        : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? appTheme.green4AColor
                          : Colors.white.withSafeOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    filter.title,
                    style: AppStyle.regular12(
                      color:
                          isSelected ? const Color(0xFF0F172A) : Colors.white70,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
