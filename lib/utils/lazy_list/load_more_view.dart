import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/widget/circle_item.dart';

class LoadMoreView<T> extends StatelessWidget {
  const LoadMoreView({
    super.key,
    this.physics,
    this.listPadding,
    this.hasRefresh = false,
    this.isLoadMore = false,
    this.isFinish = false,
    this.isShimmer = false,
    this.isFillView = true,
    this.detectAxis = Axis.vertical,
    required this.onLoadMore,
    this.children = const [],
    this.onRefresh,
    this.bottomLoadMore,
    this.child,
  }) : assert(hasRefresh && onRefresh != null);

  final Future<void> Function() onLoadMore;
  final Future<void> Function()? onRefresh;
  final Axis detectAxis;
  final ScrollPhysics? physics;
  final EdgeInsets? listPadding;
  final bool hasRefresh;
  final bool isLoadMore;
  final bool isFinish;
  final bool isFillView;
  final List<Widget> children;
  final bool isShimmer;
  final double? bottomLoadMore;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Widget body = child ??
        ListView(
            shrinkWrap: true,
            padding: listPadding ?? padding(),
            physics: physics ?? const AlwaysScrollableScrollPhysics(),
            children: children);

    body = NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0 &&
              notification.metrics.axis == detectAxis) {
            if (isLoadMore || isFinish) {
              return false;
            }
            onLoadMore();
          }
          return false;
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (isFillView) Positioned.fill(child: body) else body,
            if (!isShimmer)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                bottom: isLoadMore ? 20.h : bottomLoadMore ?? -200,
                right: 0,
                left: 0,
                child: Center(child: _buildLoadMore()),
              ),
          ],
        ));
    if (hasRefresh) {
      return RefreshIndicator(child: body, onRefresh: () => onRefresh!());
    }
    return body;
  }

  Widget _buildLoadMore() {
    return CircleItem(
        padding: padding(all: 8),
        child: SizedBox(
            height: 20.w, width: 20.w, child: CircularProgressIndicator()));
  }
}

class SimpleLoadMoreView<T> extends StatelessWidget {
  const SimpleLoadMoreView({
    super.key,
    required this.listView,
    this.physics,
    this.listPadding,
    this.hasRefresh = false,
    this.isLoadMore = false,
    this.isFinish = false,
    this.detectAxis = Axis.vertical,
    required this.onLoadMore,
    this.onRefresh,
  });

  final Future<void> Function() onLoadMore;
  final Future<void> Function()? onRefresh;
  final Axis detectAxis;
  final ScrollPhysics? physics;
  final EdgeInsets? listPadding;
  final bool hasRefresh;
  final bool isLoadMore;
  final bool isFinish;

  final Widget listView;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildBody(),
        if (isLoadMore)
          Positioned(
              bottom: 20,
              child: CircleItem(
                  padding: padding(all: 8),
                  child: SizedBox(
                      height: 20.w,
                      width: 20.w,
                      child: CircularProgressIndicator())))
      ],
    );
  }

  Widget _buildBody() {
    Widget body = NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0 &&
              notification.metrics.axis == detectAxis) {
            if (isLoadMore || isFinish) {
              return false;
            }
            onLoadMore();
          }
          return false;
        },
        child: listView);
    if (hasRefresh) {
      return RefreshIndicator(child: body, onRefresh: () => onRefresh!());
    }
    return body;
  }
}
