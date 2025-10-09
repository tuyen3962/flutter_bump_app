import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';
import 'package:flutter_bump_app/data/enum/app_enum.dart';

enum SponsorshipTabFilter { all, completed, in_progress }

class SponsorshipTabState extends BaseState {
  final SponsorshipTabFilter filter;

  const SponsorshipTabState({
    this.filter = SponsorshipTabFilter.all,
  });

  SponsorshipTabState copyWith({
    SponsorshipTabFilter? filter,
  }) {
    return SponsorshipTabState(
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [filter];
}

extension SponsorshipTabFilterExtension on SponsorshipTabFilter {
  String get title {
    switch (this) {
      case SponsorshipTabFilter.all:
        return 'All';
      case SponsorshipTabFilter.completed:
        return 'Completed';
      case SponsorshipTabFilter.in_progress:
        return 'In Progress';
    }
  }

  CampaignStatus? get campaignStatus {
    switch (this) {
      case SponsorshipTabFilter.all:
        return null;
      case SponsorshipTabFilter.completed:
        return CampaignStatus.COMPLETED;
      case SponsorshipTabFilter.in_progress:
        return CampaignStatus.IN_PROGRESS;
    }
  }
}
