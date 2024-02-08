import 'package:analects/models/creator_subscription_model.dart';

import '../app/modules/widgets/widget_imports.dart';

class CreatorSubscriptionController extends GetxController {
  final _subscriptionList = Rx<List<CreatorSubscrptionModel?>>([]);
  List<CreatorSubscrptionModel?> get subscriptionList =>
      _subscriptionList.value;

  final _db = DatabaseService();

  Stream<List<CreatorSubscrptionModel?>> getCreatorSubscriptionList() {
    return _db.creatorSubscriptionCollection
        .snapshots()
        .map((event) {
      return event.docs.map((e) => e.data()).toList();
    });
  }

  @override
  void onInit() {
    _subscriptionList.bindStream(getCreatorSubscriptionList());
    log("event length ${subscriptionList.length.toString()}");
    super.onInit();
  }

  @override
  void onClose() {
    _subscriptionList.close();
    super.onClose();
  }
}
