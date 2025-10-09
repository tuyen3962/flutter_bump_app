// import 'package:flutter/material.dart';
// import 'package:flutter_bump_app/utils/lazy_list/lazy_list_controller.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class LazyListNotifierView<T> extends StatelessWidget {
//   const LazyListNotifierView({
//     super.key,
//     required this.controller,
//     required this.viewBuilder,
//   });

//   final LazyListController<T> controller;
//   final Widget Function(bool isLoading, List<T> items, int total) viewBuilder;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: controller.isLoading,
//       builder: (context, loading, child) => ValueListenableBuilder<List<T>>(
//           valueListenable: controller.data,
//           builder: (context, items, child) => Skeletonizer(
//                 enabled: loading,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     topView?.call(items) ?? const SizedBox(),
//                     loading || items.isNotEmpty
//                         ? lineItemCount > 1
//                             ? ListVerticalItem<T>(
//                                 lineItemCount: lineItemCount,
//                                 viewPadding:
//                                     viewPadding ?? padding(vertical: 12),
//                                 isShrinkWrap: shrinkWrap,
//                                 paddingBetweenLine: 12,
//                                 paddingBetweenItem: 8,
//                                 physics: physics ??
//                                     const AlwaysScrollableScrollPhysics(),
//                                 items: items,
//                                 isLoading: loading,
//                                 skeletonView: skeletonView(),
//                                 itemBuilder: (index, item) => loading
//                                     ? skeletonView()
//                                     : itemBuilder(index, item),
//                               )
//                             : ListView.separated(
//                                 controller: scrollController,
//                                 shrinkWrap: shrinkWrap,
//                                 padding: viewPadding ?? padding(),
//                                 physics: physics ??
//                                     const AlwaysScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) => loading
//                                     ? skeletonView()
//                                     : itemBuilder(index, items[index]),
//                                 separatorBuilder: (context, index) =>
//                                     divider ?? const SizedBox(),
//                                 itemCount: loading ? 3 : items.length)
//                         : const SizedBox(),
//                   ],
//                 ),
//               )),
//     );
//   }
// }
