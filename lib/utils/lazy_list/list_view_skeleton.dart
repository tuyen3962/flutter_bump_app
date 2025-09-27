import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';

class ListViewSkeleton<T> extends StatelessWidget {
  const ListViewSkeleton(
      {super.key,
      this.isShimmer = false,
      required this.items,
      required this.itemBuilder,
      this.listPadding,
      this.reverse = false,
      this.physic,
      this.emptyView,
      this.divider});

  final bool isShimmer;
  final List<T> items;
  final Widget Function(int index, T? item) itemBuilder;
  final Widget? divider;
  final EdgeInsets? listPadding;
  final ScrollPhysics? physic;
  final bool reverse;
  final Widget? emptyView;

  @override
  Widget build(BuildContext context) {
    return isShimmer || items.isNotEmpty
        ? ListView.separated(
            physics: physic,
            reverse: reverse,
            shrinkWrap: true,
            padding: listPadding ?? padding(),
            itemBuilder: (context, index) =>
                itemBuilder(index, isShimmer ? null : items[index]),
            separatorBuilder: (context, index) => divider ?? const SizedBox(),
            itemCount: isShimmer ? 5 : items.length)
        : emptyView ?? const SizedBox();
  }
}
