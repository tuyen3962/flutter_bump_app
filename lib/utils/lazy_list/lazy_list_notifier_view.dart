// import 'package:base_module/utils/lazy_list/lazy_list_controller.dart';
// import 'package:base_module/widget/bloc/multi_notifier_builder.dart';
// import 'package:flutter/material.dart';

// class LazyListNotifierView<T> extends StatelessWidget {
//   const LazyListNotifierView({
//     super.key,
//     required this.controller,
//     required this.viewBuilder,
//   });

//   final LazyListController<T> controller;
//   final Widget Function(bool isLoading, List<T> items, int total) viewBuilder;

//   @override
//   Widget build(BuildContext context) {
//     return ThirdValueNotifier(
//         firstNotifier: controller.isLoading,
//         secondNotifier: controller.data,
//         thirdNotifier: controller.total,
//         viewBuilder: viewBuilder);
//   }
// }
