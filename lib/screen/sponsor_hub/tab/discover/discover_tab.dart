import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/data/model/creator_model.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/discover_detail/discover_detail_parameter.dart';
import 'package:flutter_bump_app/utils/lazy_list/lazy_list.dart';
import 'package:flutter_bump_app/widget/image/cache_image.dart';

import 'discover_tab_cubit.dart';
import 'discover_tab_state.dart';

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({super.key});

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState
    extends BaseBlocViewState<DiscoverTab, DiscoverTabState, DiscoverTabCubit> {
  @override
  Widget buildView(BuildContext context, DiscoverTabCubit cubit) {
    return Padding(
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
          _buildFilterTabs(),
          SizedBox(height: 16.h),

          // How Bidding Works Card
          _buildBiddingInfoCard(),
          SizedBox(height: 16.h),

          Expanded(
            child: BlocBuilder<DiscoverTabCubit, DiscoverTabState>(
              builder: (context, state) {
                return LazyListView<CreatorModel>(
                  controller: cubit.getCurrentController(),
                  emptyView: Center(
                    child: Text(
                      'No creators found.',
                      style: AppStyle.regular14(color: Colors.white60),
                    ),
                  ),
                  itemBuilder: (index, creator) =>
                      _buildCreatorCard(creator: creator),
                  skeletonView: () => _buildCreatorCard(),
                  shrinkWrap: false,
                  callInit: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return BlocBuilder<DiscoverTabCubit, DiscoverTabState>(
      builder: (context, state) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: DiscoverTabFilter.values.map((filter) {
            final isSelected = state.filter == filter;
            return Padding(
              padding: padding(right: 8.w),
              child: GestureDetector(
                onTap: () => cubit.changeFilter(filter),
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
                        filter.title,
                        style: AppStyle.regular12(
                          color: isSelected
                              ? const Color(0xFF0F172A)
                              : Colors.white70,
                        ),
                      ),
                      // if (filter['count'] != null) ...[
                      //   SizedBox(width: 6.w),
                      //   Container(
                      //     padding: padding(horizontal: 6.w, vertical: 2.h),
                      //     decoration: BoxDecoration(
                      //       color: isSelected
                      //           ? const Color(0xFF0F172A).withSafeOpacity(0.2)
                      //           : appTheme.green4AColor.withSafeOpacity(0.2),
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //     child: Text(
                      //       '${filter['count']}',
                      //       style: AppStyle.bold10(
                      //         color: isSelected
                      //             ? const Color(0xFF0F172A)
                      //             : appTheme.green4AColor,
                      //       ),
                      //     ),
                      //   ),
                      // ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
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

  // Widget _buildSearchBar() {
  //   // return Container(
  //   //   decoration: BoxDecoration(
  //   //     color: const Color(0xFF1E293B),
  //   //     borderRadius: BorderRadius.circular(12),
  //   //   ),
  //   //   child: TextField(
  //   //     controller: _searchController,
  //   //     scrollPadding: EdgeInsets.zero,
  //   //     style: AppStyle.regular14(color: Colors.white70),
  //   //     cursorColor: appTheme.appColor,
  //   //     decoration: InputDecoration(
  //   //       hintText: 'Search creators by niche...',
  //   //       hintStyle: AppStyle.regular14(color: Colors.white38),
  //   //       prefixIcon: Icon(
  //   //         Icons.search,
  //   //         color: Colors.white38,
  //   //         size: 20.w,
  //   //       ),
  //   //       border: InputBorder.none,
  //   //       contentPadding: padding(horizontal: 12, vertical: 12),
  //   //     ),
  //   //   ),
  //   // );
  //   return SearchCustomField(
  //     onGetSearchValue: cubit.onSearchChanged,
  //   );
  // }

  Widget _buildCreatorCard({CreatorModel? creator}) {
    return BlocBuilder<DiscoverTabCubit, DiscoverTabState>(
      builder: (context, state) {
        final creatorId = creator?.id ?? '';
        final hasActiveAuction =
            state.creatorId == creatorId && state.countdowns > 0;
        final countdown = hasActiveAuction ? state.countdowns : 0;
        final userBid = state.creatorId == creatorId ? state.bidAmount : null;
        final minBid = creator?.minBid ?? 0.0;

        return GestureDetector(
          onTap: () => context.pushRoute(
            DiscoverDetailRoute(
              parameter: DiscoverDetailParameter(creator: {}),
            ),
          ),
          child: Container(
            margin: padding(bottom: 16.h),
            padding: padding(horizontal: 16, top: 8, bottom: 16),
            decoration: BoxDecoration(
              gradient: hasActiveAuction
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2D4A2C),
                        Color(0xFF1E293B),
                      ],
                    )
                  : null,
              color: hasActiveAuction ? null : const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasActiveAuction
                    ? appTheme.green4AColor.withSafeOpacity(0.6)
                    : Colors.white.withSafeOpacity(0.1),
                width: hasActiveAuction ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Block ends banner
                if (hasActiveAuction)
                  Container(
                    width: double.infinity,
                    margin: padding(bottom: 16.h),
                    padding: padding(all: 12.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          appTheme.green4AColor.withSafeOpacity(0.15),
                          appTheme.green69Color.withSafeOpacity(0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: appTheme.green4AColor.withSafeOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        // LIVE AUCTION header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.green4AColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'LIVE AUCTION',
                                  style: AppStyle.bold14(
                                    color: appTheme.whiteText,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: padding(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color:
                                    appTheme.green4AColor.withSafeOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: appTheme.green4AColor,
                                    size: 18.w,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    '${(countdown ~/ 60).toString().padLeft(1, '0')}:${(countdown % 60).toString().padLeft(2, '0')}',
                                    style: AppStyle.bold16(
                                      color: appTheme.green4AColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        // Highest bid
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Highest bid:',
                              style: AppStyle.regular14(color: Colors.white70),
                            ),
                            Text(
                              '${userBid?.toStringAsFixed(1) ?? minBid.toStringAsFixed(1)} SOL',
                              style:
                                  AppStyle.bold16(color: appTheme.green4AColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                else
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
                      'Block ends in: ${'00d 00h 00m 00s'}',
                      style: AppStyle.regular12(color: Colors.white60),
                    ),
                  ),

                // Creator Info
                Row(
                  children: [
                    (creator?.avatar ?? '').isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CacheImage(
                              imageUrl: creator?.avatar ?? '',
                              size: 48.w,
                            ),
                          )
                        : Container(
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
                                creator?.username?[0].toUpperCase() ?? '',
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
                              Flexible(
                                child: Text(
                                  creator?.username ?? '',
                                  style: AppStyle.bold16(
                                      color: appTheme.whiteText),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // if (creator['hasMusic'] == true) ...[
                              //   SizedBox(width: 4.w),
                              //   Icon(
                              //     Icons.music_note,
                              //     color: Colors.white70,
                              //     size: 12.w,
                              //   ),
                              // ],
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            // creator['topics'],
                            'Gaming, Tech Reviews, Vlogs',
                            style: AppStyle.regular12(color: Colors.white60),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (creator?.rating ?? 0).floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: const Color(0xFFEAB308),
                                size: 12.w,
                              );
                            })
                              ..add(SizedBox(width: 4.w))
                              ..add(
                                Text(
                                  '${creator?.rating ?? '0'}',
                                  style:
                                      AppStyle.regular12(color: Colors.white70),
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                    if ((creator?.minBid ?? 0) > 0) ...[
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${creator?.minBid} SOL',
                            style:
                                AppStyle.bold16(color: appTheme.green4AColor),
                          ),
                          Text(
                            'min bid',
                            style: AppStyle.regular12(color: Colors.white60),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                // Stats
                if (hasActiveAuction) ...[
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCreatorStat('${creator?.followers}K', 'Followers'),
                      _buildCreatorStat(
                          '${creator?.totalViews}K', 'Total Views'),
                      _buildCreatorStat(
                          '${creator?.sponsorships}', 'Sponsorships'),
                    ],
                  ),
                ],

                SizedBox(height: 16.h),

                // Place Bid Button
                if (hasActiveAuction)
                  Column(
                    children: [
                      // "You're the highest bidder" badge
                      Container(
                        width: double.infinity,
                        padding: padding(all: 12.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF22C55E).withSafeOpacity(0.15),
                              appTheme.green4AColor.withSafeOpacity(0.15),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF22C55E).withSafeOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: const Color(0xFF22C55E),
                              size: 18.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'You\'re the highest bidder!',
                              style: AppStyle.bold14(
                                color: const Color(0xFF22C55E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 12.h),
                      // // Increase Bid button
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {

                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: appTheme.transparentColor,
                      //       elevation: 0,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       padding: padding(vertical: 14.h),
                      //     ),
                      //     child: Ink(
                      //       decoration: BoxDecoration(
                      //         gradient: LinearGradient(
                      //           colors: [
                      //             appTheme.green4AColor,
                      //             appTheme.green69Color,
                      //           ],
                      //         ),
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       child: Container(
                      //         alignment: Alignment.center,
                      //         padding: padding(vertical: 14.h),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Icon(
                      //               Icons.attach_money,
                      //               color: const Color(0xFF0F172A),
                      //               size: 18.w,
                      //             ),
                      //             SizedBox(width: 4.w),
                      //             Text(
                      //               'Increase Bid',
                      //               style: AppStyle.bold14(
                      //                 color: const Color(0xFF0F172A),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                else if (creator?.isAvailable == true)
                  _buildInlineBidForm(creator: creator)
                else
                  _buildPlaceBidButton(creator: creator),
              ],
            ),
          ),
        );
      },
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

  final TextEditingController bidController = TextEditingController();
  Widget _buildInlineBidForm({CreatorModel? creator}) {
    final minimumRequired = (creator?.minBid ?? 0);

    return BlocBuilder<DiscoverTabCubit, DiscoverTabState>(
        builder: (context, state) {
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
                  'Min: ${creator?.minBid?.toStringAsFixed(1)} SOL',
                  style: AppStyle.regular12(color: Colors.white60),
                ),
                Text(
                  // 'Balance: ${state.walletBalance.toStringAsFixed(2)} SOL',
                  '',
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
                  cubit.updateBidAmount(double.tryParse(value) ?? 0);
                },
                decoration: InputDecoration(
                  hintText: minimumRequired.toStringAsFixed(1),
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
                    const newBid = 1.0;
                    bidController.text = newBid.toStringAsFixed(1);
                    cubit.updateBidAmount(newBid);
                  }),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildQuickBidButton('+20%', () {
                    const newBid = 2.0;
                    bidController.text = newBid.toStringAsFixed(1);
                    cubit.updateBidAmount(newBid);
                  }),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildQuickBidButton('+50%', () {
                    const newBid = 5.0;
                    bidController.text = newBid.toStringAsFixed(1);
                    cubit.updateBidAmount(newBid);
                  }),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: cubit.privyWalletService.solanaBalance,
                      builder: (context, value, __) {
                        return SizedBox(
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: state.bidAmount >= minimumRequired &&
                                    state.bidAmount <= value
                                ? () {
                                    cubit.startCountdownTimer(creator!.id!);
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
                                gradient: state.bidAmount >= minimumRequired &&
                                        state.bidAmount < value
                                    ? LinearGradient(
                                        colors: [
                                          appTheme.green4AColor,
                                          appTheme.green69Color,
                                        ],
                                      )
                                    : null,
                                color: state.bidAmount >= minimumRequired &&
                                        state.bidAmount < value
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
                                      color:
                                          state.bidAmount >= minimumRequired &&
                                                  state.bidAmount <= value
                                              ? const Color(0xFF0F172A)
                                              : Colors.white38,
                                      size: 16.w,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      'Confirm Bid',
                                      style: AppStyle.bold12(
                                        color: state.bidAmount >=
                                                    minimumRequired &&
                                                state.bidAmount <= value
                                            ? const Color(0xFF0F172A)
                                            : Colors.white38,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.updateBidAmount(0);
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
    });
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

  Widget _buildPlaceBidButton({CreatorModel? creator}) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: ElevatedButton(
        onPressed: () {
          cubit.updateBidAmount(0);
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
}
