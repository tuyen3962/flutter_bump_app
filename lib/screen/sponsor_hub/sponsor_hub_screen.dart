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
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/campaign_details/campaign_details_parameter.dart';
import 'package:flutter_bump_app/screen/discover_detail/discover_detail_parameter.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/launch_sponsorship_parameter.dart';
import 'package:flutter_bump_app/screen/sponsor_hub/sponsor_hub_cubit.dart';
import 'package:flutter_bump_app/screen/sponsor_hub/tab/discover/discover_tab.dart';

import 'sponsor_hub_state.dart';
import 'tab/discover/discover_tab_cubit.dart';
import 'tab/sponsorship/sponsorship_tab_cubit.dart';

@RoutePage()
class SponsorHubPage
    extends BaseBlocProvider<SponsorHubState, SponsorHubCubit> {
  const SponsorHubPage({super.key});

  @override
  Widget buildPage() {
    return const SponsorHubScreen();
  }

  @override
  SponsorHubCubit createCubit() {
    return SponsorHubCubit(locator.get(), locator.get(), locator.get());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SponsorHubCubit>(create: (context) => createCubit()),
        BlocProvider<DiscoverTabCubit>(
          create: (context) => DiscoverTabCubit(
            bidRepository: locator.get(),
            privyWalletService: locator.get(),
          ),
        ),
        BlocProvider<SponsorshipTabCubit>(
            create: (context) => SponsorshipTabCubit()),
      ],
      child: buildPage(),
    );
  }
}

class SponsorHubScreen extends StatefulWidget {
  const SponsorHubScreen({super.key});

  @override
  State<SponsorHubScreen> createState() => SponsorHubScreenState();
}

class SponsorHubScreenState extends BaseBlocNoAppBarPageState<SponsorHubScreen,
    SponsorHubState, SponsorHubCubit> {
  // final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';

  String? _activeBidCreator;
  double _bidAmount = 0;

  @override
  bool get isSafeArea => false;

  @override
  void dispose() {
    // _searchController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context, SponsorHubCubit cubit) {
    return BlocBuilder<SponsorHubCubit, SponsorHubState>(
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
                _buildHeader(state),
                _buildStatsGrid(state),
                _buildTabBar(state, cubit),
                Expanded(
                  child: state.selectedTab == SelectedTab.discover
                      ? const DiscoverTab()
                      : _buildSponsorshipsTab(state, cubit),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(SponsorHubState state) {
    return Container(
      padding: padding(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
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
            'Sponsor Hub',
            style: AppStyle.bold20(color: appTheme.whiteText),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => context.pushRoute(const WalletRoute()),
            child: Container(
              padding: padding(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    appTheme.green4AColor,
                    appTheme.green69Color,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ValueListenableBuilder(
                valueListenable: cubit.privyWalletService.solanaBalance,
                builder: (context, value, __) => Text(
                  '${value.toStringAsFixed(1)} SOL',
                  style: AppStyle.bold14(color: const Color(0xFF0F172A)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(SponsorHubState state) {
    return Padding(
      padding: padding(all: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              title: 'Total Reach',
              value: '2.3M',
              icon: Icons.visibility,
              iconColor: const Color(0xFF3B82F6),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildStatCard(
              title: 'Total Spent',
              value: '${state.totalSpent.toStringAsFixed(1)} SOL',
              icon: Icons.attach_money,
              iconColor: appTheme.green4AColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: padding(all: 12.w),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyle.regular12(color: Colors.white70),
              ),
              Icon(icon, color: iconColor, size: 24.w),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppStyle.bold20(
              color: title.contains('Reach')
                  ? const Color(0xFF3B82F6)
                  : appTheme.green4AColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(SponsorHubState state, SponsorHubCubit cubit) {
    return Container(
      margin: padding(horizontal: 12, bottom: 16),
      padding: padding(all: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              title: 'Discover',
              isSelected: state.selectedTab == SelectedTab.discover,
              onTap: () => cubit.selectTab(SelectedTab.discover),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                _buildTab(
                  title: 'Sponsorships',
                  isSelected: state.selectedTab == SelectedTab.sponsorships,
                  onTap: () => cubit.selectTab(SelectedTab.sponsorships),
                ),
                if (state.wonAuctionsCount > 0)
                  Positioned(
                    top: 4.h,
                    right: 8.w,
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: appTheme.green4AColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${state.wonAuctionsCount}',
                          style:
                              AppStyle.bold10(color: const Color(0xFF0F172A)),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF374151) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: AppStyle.medium14(
              color: isSelected ? appTheme.whiteText : Colors.white60,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverTab(SponsorHubState state, SponsorHubCubit cubit) {
    return SingleChildScrollView(
      padding: padding(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          // _buildSearchBar(),
          // SizedBox(height: 16.h),

          // Available Channels Title
          Text(
            'Available Channels',
            style: AppStyle.medium14(color: Colors.white60),
          ),
          SizedBox(height: 16.h),

          // Filter Tabs
          _buildFilterTabs(state, cubit),
          SizedBox(height: 16.h),

          // How Bidding Works Card
          _buildBiddingInfoCard(),
          SizedBox(height: 16.h),

          // Creator Cards
          ...state.creators
              .map((creator) => _buildCreatorCard(creator, state, cubit)),
        ],
      ),
    );
  }

  Widget _buildSponsorshipsTab(SponsorHubState state, SponsorHubCubit cubit) {
    return SingleChildScrollView(
      padding: padding(horizontal: 12, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Setup Required Section
          if (state.wonAuctions.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Setup Required (${state.wonAuctions.length})',
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
            ),
            SizedBox(height: 16.h),
            ...state.wonAuctions
                .map((creator) => _buildWonAuctionCard(creator)),
            SizedBox(height: 24.h),
          ],

          // Your Sponsorships Section
          Text(
            'Your Sponsorships (${state.sponsorships.length})',
            style: AppStyle.bold18(color: appTheme.whiteText),
          ),
          SizedBox(height: 16.h),

          // Filter tabs for sponsorships
          _buildSponsorshipFilterTabs(state, cubit),
          SizedBox(height: 16.h),

          // Sponsorship cards
          ...state.sponsorships
              .where((s) =>
                  state.sponsorshipFilter == 'all' ||
                  s['status'] == state.sponsorshipFilter)
              .map((sponsorship) => _buildSponsorshipCard(sponsorship)),
        ],
      ),
    );
  }

  Widget _buildSponsorshipFilterTabs(
      SponsorHubState state, SponsorHubCubit cubit) {
    final filters = [
      {'key': 'all', 'label': 'All'},
      {'key': 'completed', 'label': 'Completed'},
      {'key': 'in_progress', 'label': 'In Progress'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = state.sponsorshipFilter == filter['key'];
          return Padding(
            padding: padding(right: 8.w),
            child: GestureDetector(
              onTap: () =>
                  cubit.selectSponsorshipFilter(filter['key'] as String),
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
                  filter['label'] as String,
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
    );
  }

  Widget _buildSponsorshipCard(Map<String, dynamic> sponsorship) {
    final isCompleted = sponsorship['status'] == 'completed';

    return Container(
      margin: padding(bottom: 16.h),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    sponsorship['creator'],
                    style: AppStyle.bold16(color: appTheme.whiteText),
                  ),
                  SizedBox(width: 8.w),
                  if (sponsorship['hasYoutube'] == true)
                    Icon(Icons.play_circle, color: Colors.red, size: 14.w),
                  if (sponsorship['hasTiktok'] == true)
                    Icon(Icons.music_note, color: Colors.white70, size: 14.w),
                ],
              ),
              Container(
                padding: padding(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF22C55E).withSafeOpacity(0.2)
                      : const Color(0xFFEAB308).withSafeOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF22C55E).withSafeOpacity(0.3)
                        : const Color(0xFFEAB308).withSafeOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  isCompleted ? 'Completed' : 'In Progress',
                  style: AppStyle.regular10(
                    color: isCompleted
                        ? const Color(0xFF22C55E)
                        : const Color(0xFFEAB308),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Budget',
                style: AppStyle.regular12(color: Colors.white60),
              ),
              Text(
                '${sponsorship['budget']} SOL',
                style: AppStyle.bold14(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration',
                style: AppStyle.regular12(color: Colors.white60),
              ),
              Text(
                sponsorship['duration'],
                style: AppStyle.bold14(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 36.h,
            child: ElevatedButton(
              onPressed: () => context.pushRoute(CampaignDetailsRoute(
                parameter: CampaignDetailsParameter(campaign: sponsorship),
              )),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF374151),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'View Details',
                style: AppStyle.medium12(color: appTheme.whiteText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWonAuctionCard(Map<String, dynamic> creator) {
    return Container(
      margin: padding(bottom: 16.h),
      padding: padding(all: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: appTheme.green4AColor.withSafeOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      appTheme.green4AColor.withSafeOpacity(0.2),
                      appTheme.green69Color.withSafeOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    creator['avatar'],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creator['name'],
                      style: AppStyle.bold16(color: appTheme.whiteText),
                    ),
                    Text(
                      creator['topics'],
                      style: AppStyle.regular12(color: Colors.white60),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Winning Bid',
                    style: AppStyle.regular10(color: appTheme.green4AColor),
                  ),
                  Text(
                    '${creator['winningBid']} SOL',
                    style: AppStyle.bold14(color: appTheme.green4AColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: () => context.pushRoute(LaunchSponsorshipRoute(
                parameter: LaunchSponsorshipParameter(creator: creator),
              )),
              style: ElevatedButton.styleFrom(
                backgroundColor: appTheme.transparentColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [appTheme.green4AColor, appTheme.green69Color],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.rocket_launch,
                        color: const Color(0xFF0F172A),
                        size: 16.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Setup',
                        style: AppStyle.bold14(color: const Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(SponsorHubState state, SponsorHubCubit cubit) {
    final filters = [
      {'key': 'all', 'label': 'All'},
      {'key': 'bidding', 'label': 'Bidding'},
      {'key': 'unbid', 'label': 'No Bids', 'count': 1},
      {'key': 'my_bidded', 'label': 'My Bids'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter['key'];
          return Padding(
            padding: padding(right: 8.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter['key'] as String;
                });
              },
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      filter['label'] as String,
                      style: AppStyle.regular12(
                        color: isSelected
                            ? const Color(0xFF0F172A)
                            : Colors.white70,
                      ),
                    ),
                    if (filter['count'] != null) ...[
                      SizedBox(width: 6.w),
                      Container(
                        padding: padding(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0F172A).withSafeOpacity(0.2)
                              : appTheme.green4AColor.withSafeOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${filter['count']}',
                          style: AppStyle.bold10(
                            color: isSelected
                                ? const Color(0xFF0F172A)
                                : appTheme.green4AColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBiddingInfoCard() {
    return Container(
      padding: padding(all: 12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            appTheme.green4AColor.withSafeOpacity(0.1),
            appTheme.green69Color.withSafeOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: appTheme.green4AColor.withSafeOpacity(0.2),
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
                'How Bidding Works',
                style: AppStyle.medium14(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '• Bid above minimum amount • Highest bid wins • Funds held in escrow • Block lasts 2 weeks',
            style: AppStyle.regular12(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatorCard(Map<String, dynamic> creator, SponsorHubState state,
      SponsorHubCubit cubit) {
    final isActiveBid = _activeBidCreator == creator['id'];
    final minBid = creator['minBid'] as double;
    final highestBid = state.highestBids[creator['id']] ?? minBid;
    final minimumRequired = highestBid >= minBid ? highestBid + 0.1 : minBid;

    return GestureDetector(
      onTap: () => context.pushRoute(
        DiscoverDetailRoute(
          parameter: DiscoverDetailParameter(creator: creator),
        ),
      ),
      child: Container(
        margin: padding(bottom: 16.h),
        padding: padding(horizontal: 16, top: 8, bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Block ends banner
            Container(
              width: double.infinity,
              margin: padding(bottom: 12.h),
              padding: padding(vertical: 8.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withSafeOpacity(0.1),
                    width: 1.w,
                  ),
                ),
              ),
              child: Text(
                'Block ends in: ${creator['blockEndsIn']}',
                style: AppStyle.regular12(color: Colors.white60),
              ),
            ),

            // Creator Info
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        appTheme.green4AColor.withSafeOpacity(0.2),
                        appTheme.green69Color.withSafeOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      creator['avatar'],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            creator['name'],
                            style: AppStyle.bold16(color: appTheme.whiteText),
                          ),
                          if (creator['hasMusic'] == true) ...[
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.music_note,
                              color: Colors.white70,
                              size: 12.w,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        creator['topics'],
                        style: AppStyle.regular12(color: Colors.white60),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < creator['rating'].floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xFFEAB308),
                            size: 12.w,
                          );
                        })
                          ..add(SizedBox(width: 4.w))
                          ..add(
                            Text(
                              '${creator['rating']}',
                              style: AppStyle.regular12(color: Colors.white70),
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${creator['minBid']} SOL',
                      style: AppStyle.bold16(color: appTheme.green4AColor),
                    ),
                    Text(
                      'min bid',
                      style: AppStyle.regular12(color: Colors.white60),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCreatorStat('${creator['followers']}K', 'Followers'),
                _buildCreatorStat('${creator['totalViews']}K', 'Total Views'),
                _buildCreatorStat('${creator['sponsorships']}', 'Sponsorships'),
              ],
            ),

            SizedBox(height: 16.h),

            // Place Bid Button
            if (isActiveBid)
              _buildInlineBidForm(creator, state, cubit, minimumRequired)
            else
              _buildPlaceBidButton(creator),
          ],
        ),
      ),
    );
  }

  Widget _buildInlineBidForm(Map<String, dynamic> creator,
      SponsorHubState state, SponsorHubCubit cubit, double minimumRequired) {
    final TextEditingController bidController = TextEditingController();

    return Container(
      padding: padding(all: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF374151).withSafeOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Min: ${minimumRequired.toStringAsFixed(1)} SOL',
                style: AppStyle.regular12(color: Colors.white60),
              ),
              Text(
                'Balance: ${state.walletBalance.toStringAsFixed(2)} SOL',
                style: AppStyle.regular12(color: Colors.white60),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: bidController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: AppStyle.bold16(color: appTheme.whiteText),
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  _bidAmount = double.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                hintText: '${minimumRequired.toStringAsFixed(1)}',
                hintStyle: AppStyle.regular14(color: Colors.white38),
                suffixText: 'SOL',
                suffixStyle: AppStyle.medium12(color: Colors.white60),
                border: InputBorder.none,
                contentPadding: padding(all: 12.w),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildQuickBidButton('+0.1', () {
                  final newBid = minimumRequired + 0.1;
                  bidController.text = newBid.toStringAsFixed(1);
                  setState(() {
                    _bidAmount = newBid;
                  });
                }),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildQuickBidButton('+20%', () {
                  final newBid = minimumRequired * 1.2;
                  bidController.text = newBid.toStringAsFixed(1);
                  setState(() {
                    _bidAmount = newBid;
                  });
                }),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildQuickBidButton('+50%', () {
                  final newBid = minimumRequired * 1.5;
                  bidController.text = newBid.toStringAsFixed(1);
                  setState(() {
                    _bidAmount = newBid;
                  });
                }),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: _bidAmount >= minimumRequired &&
                            _bidAmount <= state.walletBalance
                        ? () {
                            cubit.placeBid(creator['id'], _bidAmount);
                            setState(() {
                              _activeBidCreator = null;
                              _bidAmount = 0;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '🎯 Bid placed! You\'re the highest bidder!',
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
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.transparentColor,
                      disabledBackgroundColor: Colors.grey.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: _bidAmount >= minimumRequired &&
                                _bidAmount <= state.walletBalance
                            ? LinearGradient(
                                colors: [
                                  appTheme.green4AColor,
                                  appTheme.green69Color,
                                ],
                              )
                            : null,
                        color: _bidAmount >= minimumRequired &&
                                _bidAmount <= state.walletBalance
                            ? null
                            : Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: _bidAmount >= minimumRequired &&
                                      _bidAmount <= state.walletBalance
                                  ? const Color(0xFF0F172A)
                                  : Colors.white38,
                              size: 16.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Confirm Bid',
                              style: AppStyle.bold12(
                                color: _bidAmount >= minimumRequired &&
                                        _bidAmount <= state.walletBalance
                                    ? const Color(0xFF0F172A)
                                    : Colors.white38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _activeBidCreator = null;
                      _bidAmount = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF374151),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: padding(horizontal: 16.w),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppStyle.medium12(color: appTheme.whiteText),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceBidButton(Map<String, dynamic> creator) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _activeBidCreator = creator['id'];
            _bidAmount = 0;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.transparentColor,
          foregroundColor: const Color(0xFF0F172A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                appTheme.green4AColor,
                appTheme.green69Color,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money,
                  color: const Color(0xFF0F172A),
                  size: 16.w,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Place Bid',
                  style: AppStyle.bold14(color: const Color(0xFF0F172A)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickBidButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding(vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF374151),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppStyle.medium10(color: appTheme.whiteText),
          ),
        ),
      ),
    );
  }

  Widget _buildCreatorStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyle.bold16(color: appTheme.whiteText),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppStyle.regular12(color: Colors.white60),
        ),
      ],
    );
  }
}
