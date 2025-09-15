import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';

class DynamicGridItemView<T> extends StatelessWidget {
  const DynamicGridItemView({
    super.key,
    required this.itemBuilder,
    this.items = const [],
    this.maxItemInLine = 3,
    this.minItemInLine = 2,
    this.paddingBetweenItem,
    this.paddingBetweenLine,
    this.borderRadius = 0,
  });

  final List<T> items;
  final int maxItemInLine;
  final int minItemInLine;
  final double? paddingBetweenItem;
  final double? paddingBetweenLine;
  final Widget Function(T item, int index) itemBuilder;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    var itemInRow = minItemInLine;
    if (items.length != minItemInLine * 2) {
      itemInRow = maxItemInLine;
    }
    final column = items.length ~/ itemInRow + 1;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Column(
        children: List.generate(
          column,
          (index) {
            final currentIndex = itemInRow * index;
            return Padding(
              padding: padding(
                top: index == 0 ? 0 : paddingBetweenLine,
                bottom: index == column - 1 ? 0 : paddingBetweenLine,
              ),
              child: Row(
                children: List.generate(
                  itemInRow,
                  (i) => currentIndex + i < items.length
                      ? Expanded(
                          child: itemBuilder(
                              items[currentIndex + i], currentIndex + i))
                      : SizedBox(),
                ),
              ),
            );
          },
        ),
      ),
    );
    // return ListView.separated(
    //     shrinkWrap: true,
    //     physics: NeverScrollableScrollPhysics(),
    //     itemBuilder: (context, index) {
    //       final currentIndex = itemInRow * index;
    //       return Row(
    //         children: List.generate(
    //             itemInRow,
    //             (i) => currentIndex + i < items.length
    //                 ? Expanded(
    //                     child: itemBuilder(
    //                         items[currentIndex + i], currentIndex + i))
    //                 : SizedBox()),
    //       );
    //     },
    //     separatorBuilder: (context, index) =>
    //         SizedBox(height: paddingBetweenLine),
    //     itemCount: column);
  }
}
