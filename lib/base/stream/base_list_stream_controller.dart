import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';

class BaseListStreamController<T> extends BaseStreamController<List<T>> {
  BaseListStreamController(List<T> initialValue,
      {void Function()? onCancel, void Function()? onListen, bool? sync})
      : super(initialValue,
            onCancel: onCancel, onListen: onListen, sync: sync ?? false);

  int get length => value.length;

  int itemIndexWhere(bool Function(T) validate) {
    return value.indexWhere(validate);
  }

  void addValue(T newVal) {
    if (controller.isClosed) return;
    final newList = [...value];
    newList.add(newVal);
    value = newList;
  }

  void addAll(List<T> values) {
    if (controller.isClosed) return;
    final newList = [...value, ...values];
    value = newList;
  }

  void insert(int index, T newVal) {
    if (controller.isClosed) return;
    final newList = [...value];
    newList.insert(index, newVal);
    value = newList;
  }

  void updateIndexValue(int index, T val) {
    if (controller.isClosed) return;
    if (index != -1) {
      final newList = [...value];
      newList[index] = val;
      value = newList;
    }
  }

  void removeAt(int index) {
    if (controller.isClosed) return;
    if (index != -1) {
      final newList = [...value];
      newList.removeAt(index);
      value = newList;
    }
  }
}
