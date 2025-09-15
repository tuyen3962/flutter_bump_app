import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/widget/list_vertical_item.dart';

// enum LoadMoreListType { single, two }

class LoadMoreIndicator<T> extends StatefulWidget {
  /// Notice when using the load more indicator \n
  ///
  /// LOAD MORE THE LIST OF ITEM WHEN SCROLL TO END
  ///
  /// IN THIS WIDGET, YOU CAN IDENTIFY WITH ANY TYPE OF MODEL AND BUILD THE VIEW
  /// YOU WANT
  ///
  /// In this widget, you have to notice one function which is onLoadMore
  ///
  /// In this future function, you have to return one value which is the boolean
  ///
  /// YES: it mean you can get more items when you scroll
  ///
  /// NO: it mean there is no item got from server so it will
  /// unregister the scroll listener
  ///
  /// So when create loar more function, you have to check whelther it is in
  /// the end of item in order to return right value.
  const LoadMoreIndicator({
    required this.itemBuilder,
    super.key,
    this.items = const [],
    this.onLoadMore,
    this.isLoadingMore = false,
    this.isLoading = false,
    this.lineItemCount = 2,
    this.paddingBetweenItem = 8,
    this.paddingBetweenTwoLine = 16,
    this.emptyBuilder,
    this.bottomPadding = 0,
    this.isFinishLoadMore = false,
    this.onRefresh,
    this.distanceBetweenWithMaxScroll = 200,
    this.divideBetweenItem,
    this.isBottomLoadMore = true,
  });

  /// Passing the list of data for displaying in the view
  final List<T> items;

  /// Building the ui of item
  final Widget Function(int, T) itemBuilder;

  /// Build the empty view when the list of items is empty
  final Widget Function()? emptyBuilder;

  /// [Handle when load more appear]
  final Future<bool> Function()? onLoadMore;

  /// Check whelther this is in the load more status
  final bool isLoadingMore;

  /// Check whelther this is in the readload or loading status
  final bool isLoading;

  final Future<void> Function()? onRefresh;

  /// Displaying the list of item as two items or one item in one line
  final int lineItemCount;

  /// padding between item
  final double paddingBetweenItem;

  final double paddingBetweenTwoLine;

  /// padding bottom
  final double bottomPadding;

  final double distanceBetweenWithMaxScroll;

  final bool isFinishLoadMore;

  final Widget? divideBetweenItem;

  final bool isBottomLoadMore;

  @override
  State<LoadMoreIndicator<T>> createState() => LoadMoreIndicatorState();
}

class LoadMoreIndicatorState<T> extends State<LoadMoreIndicator<T>>
    with AutomaticKeepAliveClientMixin {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.onLoadMore != null) {
      controller.addListener(onScrollUpdate);
    }
  }

  @override
  void dispose() {
    controller.removeListener(onScrollUpdate);
    controller.dispose();
    super.dispose();
  }

  void onReListenerScroll() {
    if (widget.onLoadMore != null) {
      controller.addListener(onScrollUpdate);
    }
  }

  void onScrollUpdate() {
    if (widget.isFinishLoadMore) {
      controller.removeListener(onScrollUpdate);
      return;
    }

    if (widget.isBottomLoadMore) {
      if (controller.offset >=
          controller.position.maxScrollExtent -
              widget.distanceBetweenWithMaxScroll) {
        onLoadingMore();
      }
    } else {
      if (controller.offset == 0) {
        onLoadingMore();
      }
    }
  }

  Future<void> onLoadingMore() async {
    controller.removeListener(onScrollUpdate);
    final result = await widget.onLoadMore!();
    if (result) {
      controller.addListener(onScrollUpdate);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final view = Stack(
      children: [
        SizedBox.expand(child: _buildListItemWidget()),
        Visibility(
          visible: widget.isLoadingMore,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Align(
              alignment: widget.isBottomLoadMore
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                ),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        )
      ],
    );

    if (widget.onRefresh != null) {
      return RefreshIndicator(onRefresh: widget.onRefresh!, child: view);
    } else {
      return view;
    }
  }

  Widget _buildListItemWidget() {
    if (widget.isLoading ||
        (widget.emptyBuilder != null && widget.items.isEmpty)) {
      return Center(
        child: widget.isLoading
            ? SizedBox(
                width: 20, height: 20, child: CircularProgressIndicator())
            : widget.items.isEmpty
                ? widget.emptyBuilder!()
                : const SizedBox(),
      );
    }

    if (widget.lineItemCount > 1) {
      return ListVerticalItem(
        controller: controller,
        items: widget.items,
        divider: widget.divideBetweenItem,
        paddingBetweenItem: widget.paddingBetweenItem,
        lineItemCount: widget.lineItemCount,
        paddingBetweenLine: widget.paddingBetweenTwoLine,
        itemBuilder: (index, item) =>
            widget.itemBuilder(index, widget.items[index]),
      );
    } else {
      return ListView.separated(
          shrinkWrap: true,
          controller: controller,
          padding: EdgeInsets.only(bottom: widget.bottomPadding),
          physics: const AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: widget.items.length,
          separatorBuilder: (context, index) =>
              widget.divideBetweenItem ?? SizedBox(height: 8.h),
          itemBuilder: (context, index) =>
              widget.itemBuilder(index, widget.items[index]));
    }

    // return SingleChildScrollView(
    //   controller: controller,
    //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    //   physics: const AlwaysScrollableScrollPhysics(),
    //   padding: EdgeInsets.only(bottom: widget.bottomPadding),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       widget.topListView ?? const SizedBox(),
    //       if (widget.lineItemCount > 1) ...[
    //         ListVerticalItem(
    //           items: widget.items,
    //           divider: widget.divideBetweenItem,
    //           paddingBetweenItem: widget.paddingBetweenItem,
    //           lineItemCount: widget.lineItemCount,
    //           paddingBetweenLine: widget.paddingBetweenTwoLine,
    //           itemBuilder: (index, item) =>
    //               widget.itemBuilder(index, widget.items[index]),
    //         )
    //       ] else ...[
    //         ...List.generate(
    //           widget.items.length,
    //           (index) => Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               widget.itemBuilder(index, widget.items[index]),
    //               widget.divideBetweenItem ?? const SizedBox(height: 8),
    //             ],
    //           ),
    //         ),
    //       ]
    //     ],
    //   ),
    // );
  }

  @override
  bool get wantKeepAlive => true;
}
