import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';

class BaseMapStreamController<A, B> extends BaseStreamController<Map<A, B>> {
  BaseMapStreamController(super.initialValue);

  update(A key, B kVal) {
    final temp = value;
    temp[key] = kVal;
    value = temp;
  }
}
