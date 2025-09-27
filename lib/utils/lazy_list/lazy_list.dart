import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/widget/list_vertical_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'lazy_list_controller.dart';

class LazyListView<T> extends StatefulWidget {
  const LazyListView({
    super.key,
    required this.itemBuilder,
    required this.controller,
    required this.skeletonView,
    this.emptyView,
    this.divider,
    this.physics,
    this.listPadding,
    this.callInit = true,
    this.hasRefresh = false,
    this.shrinkWrap = true,
    this.lineItemCount = 1,
    this.topView,
    this.onRefresh,
    this.bottomView,
    this.onLoadMore,
    this.scrollController,
    this.isSameItemSize = false,
    this.buildCustomView,
    this.onEndScroll,
    this.disposeScrollCtrl = true,
    this.listAlignment,
    this.paddingBetweenItem,
    this.paddingBetweenLine,
    this.buildBackgroundList,
  });

  final Widget Function(int index, T item) itemBuilder;
  final Widget Function() skeletonView;
  final Widget? emptyView;
  final LazyListController<T> controller;
  final ScrollController? scrollController;
  final Widget? divider;
  final ScrollPhysics? physics;
  final EdgeInsets? listPadding;
  final bool hasRefresh;
  final bool callInit;
  final int lineItemCount;
  final bool shrinkWrap;
  final Widget? topView;
  final Future<void> Function()? onRefresh;
  final Widget? bottomView;
  final VoidCallback? onLoadMore;
  final bool isSameItemSize;
  final Widget Function(Widget listView)? buildCustomView;
  final VoidCallback? onEndScroll;
  final bool disposeScrollCtrl;
  final Alignment? listAlignment;
  final double? paddingBetweenLine;
  final double? paddingBetweenItem;
  final Widget Function(Widget listView)? buildBackgroundList;

  @override
  State<LazyListView<T>> createState() => LazyListViewState<T>();
}

class LazyListViewState<T> extends State<LazyListView<T>>
    with AutomaticKeepAliveClientMixin {
  LazyListController<T> get controller => widget.controller;
  late final ScrollController scrollCtrl =
      widget.scrollController ?? ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.data.value.isEmpty && widget.callInit) {
        controller.onRefresh();
      }
    });
  }

  @override
  void dispose() {
    if (widget.disposeScrollCtrl) {
      scrollCtrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final hasTopView = widget.topView != null;
    Widget child = ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, loading, child) => ValueListenableBuilder<List<T>>(
        valueListenable: controller.data,
        builder: (context, items, child) {
          final listView = items.isEmpty && !loading
              ? widget.emptyView ?? const SizedBox()
              : widget.buildBackgroundList
                      ?.call(_buildListItemView(loading, items, hasTopView)) ??
                  _buildListItemView(loading, items, hasTopView);

          return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  widget.onEndScroll?.call();
                  if (!mounted) return false;
                  if (notification.metrics.extentAfter == 0) {
                    if (controller.isLoadMore || controller.isOutOfRange) {
                      return false;
                    }
                    controller.onLoadMore();
                  }
                }
                return false;
              },
              child: hasTopView
                  ? ListView(
                      physics: widget.physics ??
                          const AlwaysScrollableScrollPhysics(),
                      controller: scrollCtrl,
                      padding: padding(),
                      children: [
                          widget.topView ?? const SizedBox(),
                          listView,
                          widget.bottomView ?? const SizedBox()
                        ])
                  : listView);
        },
      ),
    );
    if (widget.hasRefresh) {
      child = RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              controller.onRefresh(),
              if (widget.onRefresh != null) widget.onRefresh!(),
            ]);
          },
          child: child);
    }
    if (widget.buildCustomView != null) {
      return widget.buildCustomView!(child);
    }
    return child;
  }

  Widget _buildListItemView(bool loading, List<T> items, bool hasTopView) {
    return Stack(
      alignment: widget.listAlignment ?? Alignment.bottomCenter,
      children: [
        Skeletonizer(
          enabled: loading,
          child: loading || items.isNotEmpty
              ? widget.lineItemCount > 1
                  ? ListVerticalItem<T>(
                      lineItemCount: widget.lineItemCount,
                      viewPadding: widget.listPadding ?? padding(vertical: 12),
                      isShrinkWrap: hasTopView ? true : widget.shrinkWrap,
                      paddingBetweenLine: widget.paddingBetweenLine ?? 12,
                      paddingBetweenItem: widget.paddingBetweenItem ?? 8,
                      isSameSize: widget.isSameItemSize,
                      physics: hasTopView
                          ? const NeverScrollableScrollPhysics()
                          : widget.physics ??
                              const AlwaysScrollableScrollPhysics(),
                      items: items,
                      isLoading: loading,
                      controller: hasTopView ? null : scrollCtrl,
                      skeletonView: widget.skeletonView(),
                      itemBuilder: (index, item) => loading
                          ? widget.skeletonView()
                          : widget.itemBuilder(index, item),
                    )
                  : ListView.separated(
                      controller: hasTopView ? null : scrollCtrl,
                      shrinkWrap: hasTopView ? true : widget.shrinkWrap,
                      padding: widget.listPadding ?? padding(),
                      physics: hasTopView
                          ? const NeverScrollableScrollPhysics()
                          : widget.physics ??
                              const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) => loading
                          ? widget.skeletonView()
                          : widget.itemBuilder(index, items[index]),
                      separatorBuilder: (context, index) =>
                          widget.divider ?? const SizedBox(),
                      itemCount: loading ? 3 : items.length)
              : widget.emptyView ?? const SizedBox(),
        ),
        // if (!loading && items.isNotEmpty)
        // ValueListenableBuilder(
        //   valueListenable: controller.isLoadMoreNotifier,
        //   builder: (context, isLoadMore, _) => AnimatedPositioned(
        //     duration: const Duration(milliseconds: 50),
        //     bottom: isLoadMore ? 50.h : -200,
        //     right: 0,
        //     left: 0,
        //     child: Center(child: _buildLoadMore()),
        //   ),
        // )
      ],
    );
  }

  // Widget _buildLoadMore() {
  //   return CircleItem(
  //       padding: padding(all: 8),
  //       child: SizedBox(
  //           height: 20.w, width: 20.w, child: CircularProgressIndicator()));
  // }

  @override
  bool get wantKeepAlive => true;
}
