import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/widget/list_vertical_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'lazy_list_controller.dart';

class LazyListViewSkeleton<T> extends StatelessWidget {
  const LazyListViewSkeleton({
    super.key,
    required this.itemBuilder,
    required this.controller,
    required this.skeletonView,
    this.divider,
    this.physics,
    this.shrinkWrap = true,
    this.lineItemCount = 1,
    this.scrollController,
    this.viewPadding,
    this.topView,
  });

  final Widget Function(int index, T item) itemBuilder;
  final Widget Function() skeletonView;
  final ScrollController? scrollController;
  final LazyListController<T> controller;
  final Widget Function(List<T> items)? topView;
  final Widget? divider;
  final ScrollPhysics? physics;
  final int lineItemCount;
  final bool shrinkWrap;
  final EdgeInsets? viewPadding;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, loading, child) => ValueListenableBuilder<List<T>>(
        valueListenable: controller.data,
        builder: (context, items, child) =>
            NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.extentAfter == 0) {
                    if (controller.isLoadMore || controller.isOutOfRange) {
                      return false;
                    }
                    controller.onLoadMore();
                  }
                  return false;
                },
                child: Skeletonizer(
                  enabled: loading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      topView?.call(items) ?? const SizedBox(),
                      loading || items.isNotEmpty
                          ? lineItemCount > 1
                              ? ListVerticalItem<T>(
                                  lineItemCount: lineItemCount,
                                  viewPadding:
                                      viewPadding ?? padding(vertical: 12),
                                  isShrinkWrap: shrinkWrap,
                                  paddingBetweenLine: 12,
                                  paddingBetweenItem: 8,
                                  physics: physics ??
                                      const AlwaysScrollableScrollPhysics(),
                                  items: items,
                                  isLoading: loading,
                                  skeletonView: skeletonView(),
                                  itemBuilder: (index, item) => loading
                                      ? skeletonView()
                                      : itemBuilder(index, item),
                                )
                              : ListView.separated(
                                  controller: scrollController,
                                  shrinkWrap: shrinkWrap,
                                  padding: viewPadding ?? padding(),
                                  physics: physics ??
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => loading
                                      ? skeletonView()
                                      : itemBuilder(index, items[index]),
                                  separatorBuilder: (context, index) =>
                                      divider ?? const SizedBox(),
                                  itemCount: loading ? 3 : items.length)
                          : const SizedBox(),
                    ],
                  ),
                )),
      ),
    );
  }
}
