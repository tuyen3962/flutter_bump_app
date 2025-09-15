import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';

class ListVerticalItem<T> extends StatelessWidget {
  const ListVerticalItem({
    required this.itemBuilder,
    super.key,
    this.items = const [],
    this.lineItemCount = 2,
    this.paddingBetweenItem = 8,
    this.paddingBetweenLine = 4,
    this.controller,
    this.divider,
  });

  final List<T> items;
  final Widget Function(int index, T item) itemBuilder;
  final double paddingBetweenItem;
  final double paddingBetweenLine;
  final int lineItemCount;
  final Widget? divider;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final itemColumn = items.length ~/ lineItemCount + 1;
    Widget widget;
    if (divider != null) {
      widget = ListView.separated(
          controller: controller,
          itemBuilder: (context, index) => buildLineItem(index),
          separatorBuilder: (context, index) => divider!,
          itemCount: itemColumn);
    } else {
      widget = SingleChildScrollView(
        controller: controller,
        child: Column(
            children: List.generate(
                itemColumn,
                (index) => Padding(
                    padding: padding(
                        bottom:
                            index != itemColumn - 1 ? paddingBetweenLine : 0),
                    child: buildLineItem(index)))),
      );
    }
    return widget;
  }

  Widget buildLineItem(int index) {
    final currentIndex = index * lineItemCount;
    if (currentIndex >= items.length) return const SizedBox();
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          lineItemCount,
          (index) => Expanded(
            child: Padding(
                padding: padding(
                    left: index == 0 ? 0 : paddingBetweenItem,
                    right: index == 0 ? paddingBetweenItem : 0),
                child: currentIndex + index >= items.length
                    ? Container()
                    : itemBuilder(
                        currentIndex + index, items[currentIndex + index])),
          ),
        ),
      ),
    );
  }
}
