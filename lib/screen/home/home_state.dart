import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';
import 'package:flutter_bump_app/models/brand_model.dart';

class HomeState extends BaseState {
  final List<BrandModel> availableBrands;
  final BrandModel? selectedBrand;
  final String videoUrl;
  final ValidationResultState validationState;
  final String validationMessage;
  final bool showEarningsPopup;
  final int tokens;

  const HomeState({
    this.availableBrands = const [],
    this.selectedBrand,
    this.videoUrl = '',
    this.validationState = ValidationResultState.idle,
    this.validationMessage = '',
    this.showEarningsPopup = false,
    this.tokens = 142,
  });

  HomeState copyWith({
    List<BrandModel>? availableBrands,
    BrandModel? selectedBrand,
    String? videoUrl,
    ValidationResultState? validationState,
    String? validationMessage,
    bool? showEarningsPopup,
    int? tokens,
  }) {
    return HomeState(
      availableBrands: availableBrands ?? this.availableBrands,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      videoUrl: videoUrl ?? this.videoUrl,
      validationState: validationState ?? this.validationState,
      validationMessage: validationMessage ?? this.validationMessage,
      showEarningsPopup: showEarningsPopup ?? this.showEarningsPopup,
      tokens: tokens ?? this.tokens,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        availableBrands,
        selectedBrand,
        videoUrl,
        validationState,
        validationMessage,
        showEarningsPopup,
        tokens,
      ];
}

enum ValidationResultState {
  idle,
  validating,
  valid,
  invalid,
}
