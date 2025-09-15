import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class CustomBlocBuilder<S extends BaseState, T extends BaseCubit<S>>
    extends StatelessWidget {
  const CustomBlocBuilder(
      {super.key,
      required this.cubit,
      this.listenWhen,
      this.listener,
      this.buildWhen,
      required this.viewBuilder});

  final T cubit;
  final void Function(BuildContext context, S)? listener;
  final Widget Function(BuildContext context, T cubit, S state) viewBuilder;
  final bool Function(S previous, S current)? buildWhen;
  final bool Function(S previous, S current)? listenWhen;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, S>(
        bloc: cubit,
        builder: (context, state) => viewBuilder(context, cubit, state),
        listener: (context, state) {
          listener?.call(context, state);
        },
        listenWhen: listenWhen,
        buildWhen: buildWhen);
  }
}
