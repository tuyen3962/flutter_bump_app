import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/stream/base_list_stream_controller.dart';
import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';

class BaseStreamBuilder<T> extends StatelessWidget {
  const BaseStreamBuilder({super.key, required this.controller, this.builder});
  final BaseStreamController<T> controller;
  final Widget Function(T value)? builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: key,
      stream: controller.stream,
      initialData: controller.value,
      builder: (context, snapshot) {
        return builder?.call(snapshot.data ?? controller.value) ??
            const SizedBox();
      },
    );
  }
}

class BaseListStreamBuilder<T> extends StatelessWidget {
  const BaseListStreamBuilder(
      {super.key, required this.controller, this.builder});
  final BaseListStreamController<T> controller;
  final Widget Function(List<T> value)? builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: key,
      stream: controller.stream,
      initialData: controller.value,
      builder: (context, snapshot) {
        return builder?.call(snapshot.data ?? controller.value) ??
            const SizedBox();
      },
    );
  }
}

class TwoBaseStreamBuilder<A, B> extends StatelessWidget {
  const TwoBaseStreamBuilder(
      {super.key,
      required this.firstController,
      required this.secondController,
      this.builder});

  final BaseStreamController<A> firstController;
  final BaseStreamController<B> secondController;
  final Widget Function(A firstValue, B secondVal)? builder;

  @override
  Widget build(BuildContext context) {
    return BaseStreamBuilder<A>(
      controller: firstController,
      builder: (firstVal) => BaseStreamBuilder<B>(
        controller: secondController,
        builder: (value) => builder?.call(firstVal, value) ?? const SizedBox(),
      ),
    );
  }
}

class TwoBaseListStreamBuilder<A, B> extends StatelessWidget {
  const TwoBaseListStreamBuilder(
      {super.key,
      required this.firstController,
      required this.secondController,
      this.builder});

  final BaseStreamController<A> firstController;
  final BaseListStreamController<B> secondController;
  final Widget Function(A firstValue, List<B> secondVal)? builder;

  @override
  Widget build(BuildContext context) {
    return BaseStreamBuilder<A>(
      controller: firstController,
      builder: (firstVal) => BaseListStreamBuilder<B>(
        controller: secondController,
        builder: (value) => builder?.call(firstVal, value) ?? const SizedBox(),
      ),
    );
  }
}
