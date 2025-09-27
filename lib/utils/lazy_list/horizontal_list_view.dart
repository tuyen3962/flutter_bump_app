import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';

class HorizontalListView<T> extends StatelessWidget {
  const HorizontalListView(
      {super.key,
      required this.itemBuilder,
      required this.skeletonView,
      this.isLoading = false,
      this.items = const [],
      this.spacing = 0,
      this.physics,
      this.listPadding,
      this.emptyView,
      this.percentWidthView = .8,
      this.hasSetWidth = true});

  final List<T> items;
  final bool isLoading;
  final Widget Function(int index, T item) itemBuilder;
  final Widget Function() skeletonView;
  final double spacing;
  final ScrollPhysics? physics;
  final EdgeInsets? listPadding;
  final double percentWidthView;
  final bool hasSetWidth;
  final Widget? emptyView;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: listPadding ?? padding(),
      scrollDirection: Axis.horizontal,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      child: isLoading || items.isNotEmpty
          ? Row(
              spacing: spacing,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isLoading
                  ? List.generate(
                      3, (index) => _buildItem(context, index, null))
                  : List.generate(items.length,
                      (index) => _buildItem(context, index, items[index])))
          : emptyView ?? const SizedBox(),
    );
  }

  Widget _buildItem(BuildContext context, int index, T? item) {
    final itemView = item != null ? itemBuilder(index, item) : skeletonView();
    if (!hasSetWidth) {
      return itemView;
    }
    return SizedBox(
        width: context.screenWidth * percentWidthView, child: itemView);
  }
}
