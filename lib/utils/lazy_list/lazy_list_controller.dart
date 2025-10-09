import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';

class LazyListController<T> {
  final Future<PaginatedResponse<T>> Function(int page) onLoad;
  final int limit;
  // final int lineItemCount;

  LazyListController({
    required this.onLoad,
    this.limit = LIMIT,
    int? page,
    List<T>? items,
    // this.lineItemCount = 1,
  }) {
    data.value = items ?? [];
    isOutOfRange = data.value.length < limit;
    this.page = page ?? 1;
  }

  String keyword = '';

  final data = ValueNotifier<List<T>>([]);
  List<T> get list => data.value;
  int get length => data.value.length;

  set items(List<T> items) {
    data.value = items;
  }

  set list(List<T> value) => data.value = value;
  // bool get canLoadMore => !isLoadMore && !isOutOfRange;
  bool get canLoadMore => canLoadMoreNotifier.value;

  final isLoadMoreNotifier = ValueNotifier(false);
  final total = ValueNotifier(0);
  final isLoading = ValueNotifier(false);
  final canLoadMoreNotifier = ValueNotifier(false);
  bool get isLoadMore => isLoadMoreNotifier.value;
  set isLoadMore(bool value) => isLoadMoreNotifier.value = value;
  bool isOutOfRange = false;
  bool hasRefresh = false;
  int page = 1;

  void updateLoading(bool value) {
    isLoading.value = value;
  }

  void dispose() {
    isLoadMoreNotifier.dispose();
    total.dispose();
    data.dispose();
    isLoading.dispose();
    canLoadMoreNotifier.dispose();
  }

  void onClear() {
    data.value = [];
    total.value = 0;
    page = 1;
    isOutOfRange = false;
  }

  Future<void> onRefresh() async {
    canLoadMoreNotifier.value = false;
    hasRefresh = true;
    page = 1;
    isLoading.value = true;

    var models = await onLoad(page);
    data.value = models.data;
    total.value = models.pagination?.totalItems ?? 0;
    isOutOfRange = models.data.length < limit;
    isLoading.value = false;
    isLoadMoreNotifier.value = false;
    canLoadMoreNotifier.value = !isOutOfRange;
  }

  Future<List<T>> onLoadPage(int page, int limit) async {
    final result = await onLoad(page);
    var models = result;
    return models.data;
  }

  Future<void> onLoadMore() async {
    try {
      isLoadMore = true;
      page += 1;
      final result = await onLoad(page);
      var models = result;
      isOutOfRange = models.data.length < limit;
      data.value = [...data.value, ...models.data];
      isLoadMore = false;
      isLoadMoreNotifier.value = false;
      canLoadMoreNotifier.value = !isOutOfRange;
    } catch (e) {
      isLoadMore = false;
      isLoadMoreNotifier.value = false;
      canLoadMoreNotifier.value = false;
    }
  }

  void insert(int index, T newData) {
    final list = [...data.value];
    list.insert(index, newData);
    data.value = list;
    total.value += 1;
  }

  void checkExistAndInsert(
      int index, T newData, bool Function(T item) function) {
    final list = [...data.value];
    if (list.indexWhere(function) != -1) {
      return;
    }
    list.add(newData);
    data.value = list;
  }

  void addNewData(int index, T newData) {
    final list = [...data.value];
    list.insert(index, newData);
    data.value = list;
    total.value += 1;
  }

  void add(T newData) {
    final list = [...data.value];
    list.add(newData);
    data.value = list;
    total.value += 1;
  }

  void addAll(List<T> datas) {
    final list = [...data.value];
    list.addAll(datas);
    data.value = list;
    total.value += datas.length;
  }

  void updateNewData(int index, T newData) {
    final list = [...data.value];
    if (list.length <= index) return;
    list[index] = newData;
    data.value = list;
  }

  void updateItemWhere(bool Function(T item) function, T newData) {
    final list = [...data.value];
    final index = list.indexWhere(function);
    if (index == -1) return;
    list[index] = newData;
    data.value = list;
  }

  T? removeData(int index) {
    if (index == -1) return null;
    final list = [...data.value];
    final removed = list.removeAt(index);
    data.value = list;
    var count = total.value - 1;
    if (count <= 0) {
      count = 0;
    }
    total.value = count;
    return removed;
  }

  int findIndex(bool Function(T item) function) {
    return data.value.indexWhere(function);
  }

  void removeWhere(bool Function(T item) function) {
    final list = [...data.value];
    final number = list.count(function);
    list.removeWhere(function);
    final newTotal = total.value - number;
    if (newTotal < 0) {
      total.value = 0;
    } else {
      total.value = newTotal;
    }
    data.value = list;
  }
}
