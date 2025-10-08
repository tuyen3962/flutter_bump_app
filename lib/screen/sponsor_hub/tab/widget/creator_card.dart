import 'package:flutter/material.dart';
import 'package:flutter_bump_app/data/model/bid_model.dart';

class CreatorCard extends StatelessWidget {
  const CreatorCard({super.key, this.creator});

  final BidModel? creator;

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
  // final isActiveBid = _activeBidCreator == creator['id'];
  //   final minBid = creator['minBid'] as double;
  //   final highestBid = state.highestBids[creator['id']] ?? minBid;
  //   final minimumRequired = highestBid >= minBid ? highestBid + 0.1 : minBid;

  //   return GestureDetector(
  //     onTap: () => context.pushRoute(
  //       DiscoverDetailRoute(
  //         parameter: DiscoverDetailParameter(creator: creator),
  //       ),
  //     ),
  //     child: Container(
  //       margin: padding(bottom: 16.h),
  //       padding: padding(horizontal: 16, top: 8, bottom: 16),
  //       decoration: BoxDecoration(
  //         color: const Color(0xFF1E293B),
  //         borderRadius: BorderRadius.circular(12),
  //         border: Border.all(
  //           color: Colors.white.withSafeOpacity(0.1),
  //           width: 1.w,
  //         ),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Block ends banner
  //           Container(
  //             width: double.infinity,
  //             margin: padding(bottom: 12.h),
  //             padding: padding(vertical: 8.h),
  //             decoration: BoxDecoration(
  //               border: Border(
  //                 bottom: BorderSide(
  //                   color: Colors.white.withSafeOpacity(0.1),
  //                   width: 1.w,
  //                 ),
  //               ),
  //             ),
  //             child: Text(
  //               'Block ends in: ${creator['blockEndsIn']}',
  //               style: AppStyle.regular12(color: Colors.white60),
  //             ),
  //           ),

  //           // Creator Info
  //           Row(
  //             children: [
  //               Container(
  //                 width: 48.w,
  //                 height: 48.h,
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     begin: Alignment.topLeft,
  //                     end: Alignment.bottomRight,
  //                     colors: [
  //                       appTheme.green4AColor.withSafeOpacity(0.2),
  //                       appTheme.green69Color.withSafeOpacity(0.2),
  //                     ],
  //                   ),
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 child: Center(
  //                   child: Text(
  //                     creator['avatar'],
  //                     style: const TextStyle(fontSize: 24),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 12.w),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Text(
  //                           creator['name'],
  //                           style: AppStyle.bold16(color: appTheme.whiteText),
  //                         ),
  //                         if (creator['hasMusic'] == true) ...[
  //                           SizedBox(width: 4.w),
  //                           Icon(
  //                             Icons.music_note,
  //                             color: Colors.white70,
  //                             size: 12.w,
  //                           ),
  //                         ],
  //                       ],
  //                     ),
  //                     SizedBox(height: 4.h),
  //                     Text(
  //                       creator['topics'],
  //                       style: AppStyle.regular12(color: Colors.white60),
  //                     ),
  //                     SizedBox(height: 4.h),
  //                     Row(
  //                       children: List.generate(5, (index) {
  //                         return Icon(
  //                           index < creator['rating'].floor()
  //                               ? Icons.star
  //                               : Icons.star_border,
  //                           color: const Color(0xFFEAB308),
  //                           size: 12.w,
  //                         );
  //                       })
  //                         ..add(SizedBox(width: 4.w))
  //                         ..add(
  //                           Text(
  //                             '${creator['rating']}',
  //                             style: AppStyle.regular12(color: Colors.white70),
  //                           ),
  //                         ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     '${creator['minBid']} SOL',
  //                     style: AppStyle.bold16(color: appTheme.green4AColor),
  //                   ),
  //                   Text(
  //                     'min bid',
  //                     style: AppStyle.regular12(color: Colors.white60),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),

  //           SizedBox(height: 16.h),

  //           // Stats
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               _buildCreatorStat('${creator['followers']}K', 'Followers'),
  //               _buildCreatorStat('${creator['totalViews']}K', 'Total Views'),
  //               _buildCreatorStat('${creator['sponsorships']}', 'Sponsorships'),
  //             ],
  //           ),

  //           SizedBox(height: 16.h),

  //           // Place Bid Button
  //           if (isActiveBid)
  //             _buildInlineBidForm(creator, state, cubit, minimumRequired)
  //           else
  //             _buildPlaceBidButton(creator),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildCreatorStat(String value, String label) {
  //   return Column(
  //     children: [
  //       Text(
  //         value,
  //         style: AppStyle.bold16(color: appTheme.whiteText),
  //       ),
  //       SizedBox(height: 4.h),
  //       Text(
  //         label,
  //         style: AppStyle.regular12(color: Colors.white60),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildInlineBidForm(Map<String, dynamic> creator,
  //     SponsorHubState state, SponsorHubCubit cubit, double minimumRequired) {
  //   final TextEditingController bidController = TextEditingController();

  //   return Container(
  //     padding: padding(all: 12.w),
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF374151).withSafeOpacity(0.3),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Min: ${minimumRequired.toStringAsFixed(1)} SOL',
  //               style: AppStyle.regular12(color: Colors.white60),
  //             ),
  //             Text(
  //               'Balance: ${state.walletBalance.toStringAsFixed(2)} SOL',
  //               style: AppStyle.regular12(color: Colors.white60),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12.h),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: const Color(0xFF374151),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: TextField(
  //             controller: bidController,
  //             keyboardType:
  //                 const TextInputType.numberWithOptions(decimal: true),
  //             style: AppStyle.bold16(color: appTheme.whiteText),
  //             textAlign: TextAlign.center,
  //             onChanged: (value) {
  //               setState(() {
  //                 _bidAmount = double.tryParse(value) ?? 0;
  //               });
  //             },
  //             decoration: InputDecoration(
  //               hintText: '${minimumRequired.toStringAsFixed(1)}',
  //               hintStyle: AppStyle.regular14(color: Colors.white38),
  //               suffixText: 'SOL',
  //               suffixStyle: AppStyle.medium12(color: Colors.white60),
  //               border: InputBorder.none,
  //               contentPadding: padding(all: 12.w),
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 12.h),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: _buildQuickBidButton('+0.1', () {
  //                 final newBid = minimumRequired + 0.1;
  //                 bidController.text = newBid.toStringAsFixed(1);
  //                 setState(() {
  //                   _bidAmount = newBid;
  //                 });
  //               }),
  //             ),
  //             SizedBox(width: 8.w),
  //             Expanded(
  //               child: _buildQuickBidButton('+20%', () {
  //                 final newBid = minimumRequired * 1.2;
  //                 bidController.text = newBid.toStringAsFixed(1);
  //                 setState(() {
  //                   _bidAmount = newBid;
  //                 });
  //               }),
  //             ),
  //             SizedBox(width: 8.w),
  //             Expanded(
  //               child: _buildQuickBidButton('+50%', () {
  //                 final newBid = minimumRequired * 1.5;
  //                 bidController.text = newBid.toStringAsFixed(1);
  //                 setState(() {
  //                   _bidAmount = newBid;
  //                 });
  //               }),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12.h),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: SizedBox(
  //                 height: 40.h,
  //                 child: ElevatedButton(
  //                   onPressed: _bidAmount >= minimumRequired &&
  //                           _bidAmount <= state.walletBalance
  //                       ? () {
  //                           cubit.placeBid(creator['id'], _bidAmount);
  //                           setState(() {
  //                             _activeBidCreator = null;
  //                             _bidAmount = 0;
  //                           });
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             SnackBar(
  //                               content: Text(
  //                                 '🎯 Bid placed! You\'re the highest bidder!',
  //                                 style: AppStyle.medium14(
  //                                   color: appTheme.whiteText,
  //                                 ),
  //                               ),
  //                               backgroundColor: appTheme.green4AColor,
  //                               behavior: SnackBarBehavior.floating,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(8),
  //                               ),
  //                             ),
  //                           );
  //                         }
  //                       : null,
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: appTheme.transparentColor,
  //                     disabledBackgroundColor: Colors.grey.shade800,
  //                     elevation: 0,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     padding: EdgeInsets.zero,
  //                   ),
  //                   child: Ink(
  //                     decoration: BoxDecoration(
  //                       gradient: _bidAmount >= minimumRequired &&
  //                               _bidAmount <= state.walletBalance
  //                           ? LinearGradient(
  //                               colors: [
  //                                 appTheme.green4AColor,
  //                                 appTheme.green69Color,
  //                               ],
  //                             )
  //                           : null,
  //                       color: _bidAmount >= minimumRequired &&
  //                               _bidAmount <= state.walletBalance
  //                           ? null
  //                           : Colors.grey.shade800,
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Icon(
  //                             Icons.attach_money,
  //                             color: _bidAmount >= minimumRequired &&
  //                                     _bidAmount <= state.walletBalance
  //                                 ? const Color(0xFF0F172A)
  //                                 : Colors.white38,
  //                             size: 16.w,
  //                           ),
  //                           SizedBox(width: 4.w),
  //                           Text(
  //                             'Confirm Bid',
  //                             style: AppStyle.bold12(
  //                               color: _bidAmount >= minimumRequired &&
  //                                       _bidAmount <= state.walletBalance
  //                                   ? const Color(0xFF0F172A)
  //                                   : Colors.white38,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: 8.w),
  //             SizedBox(
  //               height: 40.h,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     _activeBidCreator = null;
  //                     _bidAmount = 0;
  //                   });
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: const Color(0xFF374151),
  //                   elevation: 0,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   padding: padding(horizontal: 16.w),
  //                 ),
  //                 child: Text(
  //                   'Cancel',
  //                   style: AppStyle.medium12(color: appTheme.whiteText),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPlaceBidButton(Map<String, dynamic> creator) {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 44.h,
  //     child: ElevatedButton(
  //       onPressed: () {
  //         setState(() {
  //           _activeBidCreator = creator['id'];
  //           _bidAmount = 0;
  //         });
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: appTheme.transparentColor,
  //         foregroundColor: const Color(0xFF0F172A),
  //         elevation: 0,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         padding: EdgeInsets.zero,
  //       ),
  //       child: Ink(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               appTheme.green4AColor,
  //               appTheme.green69Color,
  //             ],
  //           ),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Container(
  //           alignment: Alignment.center,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Icons.attach_money,
  //                 color: const Color(0xFF0F172A),
  //                 size: 16.w,
  //               ),
  //               SizedBox(width: 4.w),
  //               Text(
  //                 'Place Bid',
  //                 style: AppStyle.bold14(color: const Color(0xFF0F172A)),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
