import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';

extension StringController on String {
  BaseStreamController<String> get stream => BaseStreamController<String>(this);
}

extension NumberController on num {
  BaseStreamController<num> get stream => BaseStreamController<num>(this);
}

extension NumberIntController on int {
  BaseStreamController<int> get stream => BaseStreamController<int>(this);
}

extension NumberDoubleController on double {
  BaseStreamController<double> get stream => BaseStreamController<double>(this);
}
