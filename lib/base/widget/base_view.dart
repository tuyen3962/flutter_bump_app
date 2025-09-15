import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_controller.dart';

abstract class BaseViewState<S extends StatefulWidget, C extends BaseController>
    extends State<S> with WidgetsBindingObserver {
  late final C controller;

  C initController();

  @override
  void initState() {
    controller = initController();
    super.initState();
  }

  @override
  void dispose() {
    controller.onDispose();
    super.dispose();
  }
}
