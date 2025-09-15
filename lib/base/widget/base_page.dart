import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/utils/loading.dart';
import 'package:flutter_bump_app/widget/appbar_custom.dart';
import 'package:flutter_bump_app/widget/circle_item.dart';

import '../../../config/theme/style/style_theme.dart';
import 'cubit/base_bloc_provider.dart';
import 'cubit/base_cubit.dart';
import 'cubit/base_state.dart';

abstract class BaseBlocPageState<S extends StatefulWidget, P extends BaseState, C extends BaseCubit<P>>
    extends BaseBlocViewState<S, P, C> {
  bool get isResizeToAvoidBottomInset => true;

  bool get scaleByKeyboard => true;

  final _keyboardDismissPaddingNotifier = ValueNotifier<double>(0.0);
  ValueNotifier<double> get keyboardHeightNotifier => _keyboardDismissPaddingNotifier;

  Color get backgroundColor => appTheme.background;

  bool get isSafeArea => true;

  bool get showBack => true;

  String get title => '';

  bool? isTopSafeArea;
  bool? isBottomSafeArea;
  bool? isRightSafeArea;
  bool? isLeftSafeArea;

  CrossAxisAlignment get crossAxisAlignment => CrossAxisAlignment.center;
  String? get instanceName => null;

  double _bottomButtonHeight = 0;

  C get cubit {
    if (context.mounted) {
      return context.read<C>();
    } else {
      throw Exception('context is not mounted');
    }
  }

  void setBottomButtonHeight(double value) {
    _bottomButtonHeight = value;
  }

  void unfocusNode(PointerDownEvent event) {
    if (!mounted) return;
    FocusScope.of(context).unfocus();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!mounted) return;
    if (!isResizeToAvoidBottomInset && scaleByKeyboard) {
      /// this mean keyboard appear
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
        Future.delayed(const Duration(milliseconds: 150)).then((value) {
          if (!mounted) return;
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          _keyboardDismissPaddingNotifier.value = keyboardHeight + _bottomButtonHeight;
        });
      } else {
        if (!mounted) return;
        _keyboardDismissPaddingNotifier.value = 0;
      }
    }
  }

  bool get canPop => true;

  bool get showAppName => true;

  Color get pageBackgroundColor => backgroundColor;

  @override
  Widget buildView(BuildContext context, C cubit) {
    return ValueListenableBuilder(
      valueListenable: _keyboardDismissPaddingNotifier,
      builder: (context, bottomPadding, child) => GestureDetector(
        onTap: () => unfocusNode(const PointerDownEvent()),
        behavior: HitTestBehavior.deferToChild,
        child: Scaffold(
          backgroundColor: pageBackgroundColor,
          resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
          body: PopScope(
            canPop: canPop,
            onPopInvokedWithResult: (didPop, result) {
              unfocusNode(const PointerDownEvent());
              onPopInvoke();
              dismissLoading();
              if (didPop) {
                return;
              }
              handleBackEvent();
            },
            child: TapRegion(
                onTapInside: (_) {
                  if (FocusScope.of(context).hasFocus) {
                    return;
                  }
                  unfocusNode(_);
                },
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SafeArea(
                      left: isLeftSafeArea ?? isSafeArea,
                      right: isRightSafeArea ?? isSafeArea,
                      top: isTopSafeArea ?? isSafeArea,
                      bottom: isBottomSafeArea ?? isSafeArea,
                      child: Column(
                        crossAxisAlignment: crossAxisAlignment,
                        children: [
                          GestureDetector(onTap: FocusScope.of(context).unfocus, child: buildAppBar(context, cubit)),
                          Expanded(
                              child: hasBackgroundBody
                                  ? buildBackgroundBody(buildBody(context, cubit))
                                  : buildBody(context, cubit)),
                          buildBottomView(context, cubit),
                        ],
                      ),
                    ),
                    ...buildBackgroundView(context, cubit),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget buildBlocView({required Widget Function(BuildContext context, P state) viewBuilder}) {
    return BlocBuilder<C, P>(bloc: cubit, builder: viewBuilder);
  }

  Widget buildBlocConsumerView(
      {required Widget Function(BuildContext context, P state) viewBuilder,
      required void Function(BuildContext context, P state) listener}) {
    return BlocConsumer<C, P>(bloc: cubit, builder: viewBuilder, listener: listener);
  }

  void onPopInvoke() {}

  void handleBackEvent() {}

  void onBack() {
    if (context.mounted) {
      Navigator.of(context).maybePop();
    }
  }

  List<Widget> buildBackgroundView(BuildContext context, C cubit) => [];

  bool get hasBackgroundBody => false;

  Widget buildBackgroundBody(Widget child) => SizedBox(child: child);

  Color? get backgroundAppBarColor => null;

  Color? get titleAppBarColor => null;

  bool get isBackIcon => true;

  String? getScreenTitle(C cubit) => null;

  List<Widget>? appBarActions(C cubit) => [];

  Widget? appBarBacKIcon(C cubit) => CircleItem(
        onTap: onBack,
        padding: padding(all: 6),
        backgroundColor: appTheme.gray50.withOpacity(.16),
        child: Icon(Icons.arrow_back_ios_new_rounded, color: appTheme.gray50, size: 20),
      );

  Widget? appBarTitle(C cubit) => null;

  Widget buildAppBar(BuildContext context, C cubit) {
    final appbar = AppBarCustom(
      title: getScreenTitle.call(cubit) ?? title,
      showBack: showBack,
      onBack: onBack,
      titleView: appBarTitle(cubit),
      actions: appBarActions(cubit),
      backIcon: appBarBacKIcon(cubit),
      isBackIcon: isBackIcon,
      backColor: titleAppBarColor,
      backgroundColor: backgroundAppBarColor,
      titleStyle: AppStyle.bold18(color: titleAppBarColor),
    );
    if (isTopSafeArea == false || isSafeArea == false) {
      return Container(
        color: backgroundAppBarColor ?? appTheme.gray50,
        child: SafeArea(bottom: false, child: appbar),
      );
    }

    return appbar;
  }

  Widget buildBody(BuildContext context, C cubit) => Container();

  Widget buildBottomView(BuildContext context, C cubit) => const SizedBox();
}

abstract class BaseBlocNoAppBarPageState<S extends StatefulWidget, P extends BaseState, C extends BaseCubit<P>>
    extends BaseBlocPageState<S, P, C> {
  @override
  Widget buildAppBar(BuildContext context, C cubit) => const SizedBox();
}

abstract class BaseBlocPrimaryAppBarPageState<S extends StatefulWidget, P extends BaseState, C extends BaseCubit<P>>
    extends BaseBlocPageState<S, P, C> {
  @override
  Color? get titleAppBarColor => appTheme.gray50;
  @override
  Color get backgroundColor => appTheme.gray50;
  @override
  Color? get backgroundAppBarColor => appTheme.whiteText;
  @override
  bool? get isTopSafeArea => false;

  @override
  Widget? appBarBacKIcon(C cubit) {
    return CircleItem(
        onTap: onBack,
        padding: padding(all: 6),
        backgroundColor: appTheme.gray50.withOpacity(.16),
        child: Icon(Icons.arrow_back_ios_new_rounded, color: appTheme.gray50, size: 20));
  }
}
