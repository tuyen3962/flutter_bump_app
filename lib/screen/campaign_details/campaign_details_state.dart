import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class CampaignDetailsState extends BaseState {
  final String creatorName;
  final String status;
  final String duration;
  final double budget;
  final Map<String, String> socialLinks;
  final List<Map<String, dynamic>> videos;

  const CampaignDetailsState({
    super.isLoading = false,
    this.creatorName = '@cryptoqueen_',
    this.status = 'Completed',
    this.duration = 'Oct 6 → Oct 20',
    this.budget = 2.5,
    this.socialLinks = const {},
    this.videos = const [],
  });

  CampaignDetailsState copyWith({
    String? creatorName,
    String? status,
    String? duration,
    double? budget,
    Map<String, String>? socialLinks,
    List<Map<String, dynamic>>? videos,
  }) {
    return CampaignDetailsState(
      creatorName: creatorName ?? this.creatorName,
      status: status ?? this.status,
      duration: duration ?? this.duration,
      budget: budget ?? this.budget,
      socialLinks: socialLinks ?? this.socialLinks,
      videos: videos ?? this.videos,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        creatorName,
        status,
        duration,
        budget,
        socialLinks,
        videos,
      ];
}
