import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';

class CampaignDetailsState extends BaseState {
  // final String creatorName;
  // final String status;
  // final String duration;
  // final double budget;
  // final Map<String, String> socialLinks;
  // final List<Map<String, dynamic>> videos;
  final CampaignModel? campaign;
  final bool notFound;

  const CampaignDetailsState({
    super.isLoading = false,
    // this.creatorName = '@cryptoqueen_',
    // this.status = 'Completed',
    // this.duration = 'Oct 6 → Oct 20',
    // this.budget = 2.5,
    // this.socialLinks = const {},
    // this.videos = const [],
    this.campaign,
    this.notFound = false,
  });

  CampaignDetailsState copyWith({
    // String? creatorName,
    // String? status,
    // String? duration,
    // double? budget,
    // Map<String, String>? socialLinks,
    // List<Map<String, dynamic>>? videos,
    CampaignModel? campaign,
    bool? notFound,
  }) {
    return CampaignDetailsState(
      //  creatorName: creatorName ?? this.creatorName,
      // status: status ?? this.status,
      // duration: duration ?? this.duration,
      // budget: budget ?? this.budget,
      // socialLinks: socialLinks ?? this.socialLinks,
      campaign: campaign ?? this.campaign,
      notFound: notFound ?? this.notFound,
      // videos: videos ?? this.videos,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        //  creatorName,
        // status,
        // duration,
        // budget,
        // socialLinks,
        // videos,
        campaign,
        notFound,
      ];
}
