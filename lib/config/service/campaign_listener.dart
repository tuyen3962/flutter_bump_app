import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:injectable/injectable.dart';

abstract class BaseCampaignListenerEvent {
  final String campaignId;

  BaseCampaignListenerEvent(this.campaignId);
}

class CampaignUpdatedEvent extends BaseCampaignListenerEvent {
  final CampaignModel campaign;

  CampaignUpdatedEvent(super.campaignId, this.campaign);
}

@singleton
class CampaignListener {
  final List<Function(BaseCampaignListenerEvent)> _listeners = [];

  void listen(Function(BaseCampaignListenerEvent) event) {
    _listeners.add(event);
  }

  void remove(Function(BaseCampaignListenerEvent) event) {
    _listeners.remove(event);
  }

  void emit<T extends BaseCampaignListenerEvent>(T newEvent) {
    for (var event in _listeners) {
      event(newEvent);
    }
  }
}
