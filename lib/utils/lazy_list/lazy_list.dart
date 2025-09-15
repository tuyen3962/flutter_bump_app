import 'package:flutter/material.dart';
import 'package:flutter_bump_app/utils/lazy_list/lazy_list_controller.dart';

class LazyListView<T> extends StatefulWidget {
  const LazyListView({
    super.key,
    required this.itemBuilder,
    required this.controller,
    this.divider,
    this.hasRefresh = false,
  });

  final Widget Function(int index, T item) itemBuilder;
  final LazyListController<T> controller;
  final Widget? divider;
  final bool hasRefresh;

  @override
  State<LazyListView<T>> createState() => LazyListViewState<T>();
}

class LazyListViewState<T> extends State<LazyListView<T>> {
  LazyListController<T> get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final child = ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, loading, child) => loading
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder<List<T>>(
              valueListenable: controller.data,
              builder: (context, items, child) =>
                  NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification &&
                            notification.metrics.extentAfter == 0) {
                          if (controller.isLoadMore || controller.isOutOfRange)
                            return false;
                          controller.onLoadMore();
                        }
                        return false;
                      },
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              widget.itemBuilder(index, items[index]),
                          separatorBuilder: (context, index) =>
                              widget.divider ?? const SizedBox(),
                          itemCount: items.length)),
            ),
    );
    if (widget.hasRefresh) {
      return RefreshIndicator(onRefresh: controller.onRefresh, child: child);
    }
    return child;
  }
}
