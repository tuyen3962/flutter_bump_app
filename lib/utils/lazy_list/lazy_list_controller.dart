import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';

class LazyListController<T> {
  final Future<List<T>> Function(int page) onLoad;
  final int limit;

  LazyListController({required this.onLoad, this.limit = LIMIT});

  final data = ValueNotifier<List<T>>([]);
  final isLoading = ValueNotifier(false);
  var isLoadMore = false;
  bool isOutOfRange = false;

  int page = 1;

  void dispose() {
    data.dispose();
    isLoading.dispose();
  }

  Future<void> onRefresh() async {
    page = 1;
    isLoading.value = true;
    final result = await onLoad(page);
    data.value = result;
    isOutOfRange = result.length < LIMIT;
    isLoading.value = false;
  }

  Future<void> onLoadMore() async {
    isLoadMore = true;
    page += 1;
    final result = await onLoad(page);
    isOutOfRange = result.length < LIMIT;
    data.value = [...data.value, ...result];
    isLoadMore = false;
  }
}
