import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/screen/campaign_details/campaign_details_parameter.dart';

import 'campaign_details_state.dart';

class CampaignDetailsCubit extends BaseCubit<CampaignDetailsState> {
  late final AccountService accountService = locator.get();

  final CampaignDetailsParameter parameter;

  CampaignDetailsCubit({required this.parameter})
      : super(CampaignDetailsState(
          creatorName: parameter.campaign['creator'] ?? '@cryptoqueen_',
          status: parameter.campaign['status'] == 'completed'
              ? 'Completed'
              : 'In Progress',
          duration: parameter.campaign['duration'] ?? 'Oct 6 → Oct 20',
          budget: (parameter.campaign['budget'] as num?)?.toDouble() ?? 2.5,
          socialLinks: const {
            'website': 'defiprotocol.io',
            'twitter': '@defiprotocol',
            'telegram': '@defiprotocol_official',
            'discord': 'discord.gg/defiprotocol',
          },
          videos: const [
            {
              'title': 'DeFi Protocol Introduction',
              'views': '125K',
              'date': '2d ago',
              'requirementsMet': 4,
              'totalRequirements': 4,
              'requirements': [
                {'label': 'Brand mention in first 5s', 'completed': true},
                {'label': 'Hashtag #SPONSOR.FUN visible', 'completed': true},
                {'label': 'Product shot minimum 3s', 'completed': true},
                {'label': 'Call-to-action included', 'completed': true},
              ],
            },
            {
              'title': 'High APY Staking Guide',
              'views': '89K',
              'date': '4d ago',
              'requirementsMet': 3,
              'totalRequirements': 4,
              'requirements': [
                {'label': 'Brand mention in first 5s', 'completed': true},
                {'label': 'Hashtag #SPONSOR.FUN visible', 'completed': true},
                {'label': 'Product shot minimum 3s', 'completed': false},
                {'label': 'Call-to-action included', 'completed': true},
              ],
            },
            {
              'title': 'Security Features Demo',
              'views': '53K',
              'date': '6d ago',
              'requirementsMet': 4,
              'totalRequirements': 4,
              'requirements': [
                {'label': 'Brand mention in first 5s', 'completed': true},
                {'label': 'Hashtag #SPONSOR.FUN visible', 'completed': true},
                {'label': 'Product shot minimum 3s', 'completed': true},
                {'label': 'Call-to-action included', 'completed': true},
              ],
            },
          ],
        ));
}
