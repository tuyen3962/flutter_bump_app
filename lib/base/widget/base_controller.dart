import 'package:flutter/cupertino.dart';
import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';

class BaseController {
  late final List<BaseStreamController> streamCtrls = [];

  late final List<TextEditingController> textCtrls = [];

  late final List<ValueNotifier> notifiers = [];

  final State<StatefulWidget> state;
  final BuildContext context;

  BaseController(this.state) : context = state.context {
    onInit();
  }

  void onInit() {}

  void onDispose() {
    for (final controller in streamCtrls) {
      controller.dispose();
    }
    for (final controller in textCtrls) {
      controller.dispose();
    }
    for (final controller in notifiers) {
      controller.dispose();
    }
  }
}
