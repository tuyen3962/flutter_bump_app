import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';

import 'lazy_list_controller.dart';

class HorizontalLazyList<T> extends StatefulWidget {
  const HorizontalLazyList(
      {super.key,
      required this.itemBuilder,
      required this.controller,
      required this.skeletonView,
      this.physics,
      this.listPadding,
      this.callInit = true,
      this.emptyView,
      this.onLoadMore,
      this.bottomView,
      this.percentWidthView = .8,
      this.noSizeView = false,
      this.spacing = 8,
      this.firstItem});

  final Widget Function(int index, T item) itemBuilder;
  final Widget Function() skeletonView;
  final LazyListController<T> controller;
  final double spacing;
  final ScrollPhysics? physics;
  final EdgeInsets? listPadding;
  final bool callInit;
  final double percentWidthView;
  final Widget? emptyView;
  final VoidCallback? onLoadMore;
  final Widget? bottomView;
  final bool noSizeView;
  final Widget? firstItem;

  @override
  State<HorizontalLazyList<T>> createState() => HorizontalLazyListState<T>();
}

class HorizontalLazyListState<T> extends State<HorizontalLazyList<T>> {
  LazyListController<T> get controller => widget.controller;
  final ScrollController scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    if (controller.data.value.isEmpty && widget.callInit) {
      controller.onRefresh();
    }
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.isLoading,
        builder: (context, loading, child) => ValueListenableBuilder<List<T>>(
            valueListenable: controller.data,
            builder: (context, items, child) => items.isEmpty && !loading
                ? widget.emptyView ?? const SizedBox()
                : NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification &&
                          notification.metrics.axis == Axis.horizontal &&
                          notification.metrics.extentAfter == 0) {
                        if (controller.isLoadMore || controller.isOutOfRange) {
                          return false;
                        }
                        if (widget.onLoadMore != null) {
                          widget.onLoadMore!();
                        } else {
                          controller.onLoadMore();
                        }
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      controller: scrollCtrl,
                      padding: widget.listPadding ?? padding(),
                      scrollDirection: Axis.horizontal,
                      physics: widget.physics ??
                          const AlwaysScrollableScrollPhysics(),
                      child: loading || items.isNotEmpty
                          ? Row(
                              spacing: widget.spacing,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...(loading
                                    ? List.generate(
                                        3,
                                        (index) => widget.noSizeView
                                            ? widget.skeletonView()
                                            : SizedBox(
                                                width: context.screenWidth *
                                                    widget.percentWidthView,
                                                child: widget.skeletonView()))
                                    : [
                                        if (widget.firstItem != null)
                                          widget.firstItem!,
                                        ...items
                                            .asMap()
                                            .entries
                                            .map((map) => widget.noSizeView
                                                ? widget.itemBuilder(
                                                    map.key, map.value)
                                                : SizedBox(
                                                    width: context.screenWidth *
                                                        widget.percentWidthView,
                                                    child: widget.itemBuilder(
                                                        map.key, map.value),
                                                  ))
                                            .toList()
                                      ]),
                                if (widget.bottomView != null)
                                  widget.bottomView!,
                              ],
                            )
                          : widget.emptyView ?? const SizedBox(),
                    ))));
  }
}
