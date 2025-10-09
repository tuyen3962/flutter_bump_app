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
import 'package:flutter_bump_app/widget/search_custom_filed.dart';

import 'discover_tab_cubit.dart';
import 'discover_tab_state.dart';

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({super.key});

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState
    extends BaseBlocViewState<DiscoverTab, DiscoverTabState, DiscoverTabCubit> {
  double _bidAmount = 0;

  @override
  Widget buildView(BuildContext context, DiscoverTabCubit cubit) {
    return Padding(
      padding: padding(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          _buildSearchBar(),
          SizedBox(height: 16.h),

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

  Widget _buildSearchBar() {
    // return Container(
    //   decoration: BoxDecoration(
    //     color: const Color(0xFF1E293B),
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child: TextField(
    //     controller: _searchController,
    //     scrollPadding: EdgeInsets.zero,
    //     style: AppStyle.regular14(color: Colors.white70),
    //     cursorColor: appTheme.appColor,
    //     decoration: InputDecoration(
    //       hintText: 'Search creators by niche...',
    //       hintStyle: AppStyle.regular14(color: Colors.white38),
    //       prefixIcon: Icon(
    //         Icons.search,
    //         color: Colors.white38,
    //         size: 20.w,
    //       ),
    //       border: InputBorder.none,
    //       contentPadding: padding(horizontal: 12, vertical: 12),
    //     ),
    //   ),
    // );
    return SearchCustomField(
      onGetSearchValue: cubit.onSearchChanged,
      
    );
  }

  Widget _buildCreatorCard({CreatorModel? creator}) {
    return BlocBuilder<DiscoverTabCubit, DiscoverTabState>(
      builder: (context, state) {
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
                SizedBox(height: 16.h),
                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCreatorStat('${creator?.followers}K', 'Followers'),
                    _buildCreatorStat('${creator?.totalViews}K', 'Total Views'),
                    _buildCreatorStat(
                        '${creator?.sponsorships}', 'Sponsorships'),
                  ],
                ),

                SizedBox(height: 16.h),

                // Place Bid Button
                if (creator?.isAvailable == true)
                  _buildInlineBidForm(state, creator: creator)
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

  Widget _buildInlineBidForm(DiscoverTabState state, {CreatorModel? creator}) {
    final TextEditingController bidController = TextEditingController();
    final minimumRequired = (creator?.minBid ?? 0) + 0.1;

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
                setState(() {
                  _bidAmount = double.tryParse(value) ?? 0;
                });
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
                            cubit.placeBid(creator!.id!, _bidAmount);
                            setState(() {
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
          setState(() {
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
}
