import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

abstract class BaseBlocProvider<S extends BaseState, T extends BaseCubit<S>>
    extends StatelessWidget {
  const BaseBlocProvider({super.key});

  T createCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (context) => createCubit(),
      child: buildPage(),
    );
  }

  Widget buildPage();
}

abstract class BaseBlocProviderParameter<S extends BaseState,
    T extends BaseCubit<S>, P> extends BaseBlocProvider<S, T> {
  const BaseBlocProviderParameter({super.key, required this.parameter});

  /// Parameter
  final P parameter;

  @override
  T createCubit() {
    throw Exception();
  }

  @override
  Widget buildPage() {
    return const SizedBox();
  }

  T createCubitWithParam(P param);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (context) => createCubitWithParam(parameter),
      child: buildPageWithParam(parameter),
    );
  }

  Widget buildPageWithParam(P param);
}

abstract class BaseBlocViewState<S extends StatefulWidget, P extends BaseState,
    T extends BaseCubit<P>> extends State<S> with WidgetsBindingObserver {
  bool get handleInitState => true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (handleInitState) {
      final cubit = context.read<T>();
      cubit.onInit();
      WidgetsBinding.instance.addPostFrameCallback((_) => cubit.onReady());
    }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<T>();
    return buildView(context, cubit);
  }

  /// Takes the previous `state` and the current `state` and is responsible for
  /// returning a [bool] which determines whether or not to call [listener] of
  /// [BlocConsumer] with the current `state`.
  bool listenWhen(P previous, P current) => true;

  /// Takes the previous `state` and the current `state` and is responsible for
  /// returning a [bool] which determines whether or not to trigger
  /// [builder] with the current `state`.
  bool buildWhen(P previous, P current) => true;

  void onStateChange(P newState) {}

  Widget buildView(BuildContext context, T cubit);
}
