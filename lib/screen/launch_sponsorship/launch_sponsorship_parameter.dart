import 'package:flutter_bump_app/data/model/campagin.dart';

class LaunchSponsorshipParameter {
  final CampaignModel campaign;
  final bool fillInfo;

  LaunchSponsorshipParameter({required this.campaign, this.fillInfo = false});
}
