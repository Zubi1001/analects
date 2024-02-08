// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/analect_model.dart';

class CreatorProfileController extends GetxController {
  final user = Get.find<UserController>().currentUser;

  final _creatorAnalectList = Rx<List<AnalectModel?>>([]);
  List<AnalectModel?> get analectList => _creatorAnalectList.value;

  ///
  final Rxn<UserModel?> _creatorData = Rxn<UserModel?>();
  UserModel? get creator => _creatorData.value;

  final RxBool _followed = false.obs;
  bool get followed => _followed.value;

  final RxBool _subscribed = false.obs;
  bool get subscribed => _subscribed.value;

  final _db = DatabaseService();

  Future<List<AnalectModel?>> creatorsAnalects(
      {required String? creatorUid}) async {
    var results = await _db.analectsCollection
        .where("creatorId", isEqualTo: creatorUid ?? user!.id)
        .orderBy("timestamp", descending: true)
        .get();
    return _creatorAnalectList.value =
        results.docs.map((e) => e.data()!).toList();
  }

  Future<bool> checkFollower({required String? creatorId}) async {
    var followRef = _db.userCollection.doc(creatorId);
    var docSnapshot =
        await followRef.collection("followers").doc(user!.id).get();
    if (docSnapshot.exists) {
      _followed.value = true;
      return true;
    } else {
      _followed.value = false;
      return false;
    }
  }

  void setFollow({required String creatorId}) {
    if (followed) {
      _followed.value = false;

      _db.userCollection
          .doc(creatorId)
          .collection("followers")
          .doc(user!.id)
          .delete();
      _db.userCollection
          .doc(user!.id)
          .collection("following")
          .doc(creatorId)
          .delete();

      _db.userCollection
          .doc(creatorId)
          .update({"followers": FieldValue.increment(-1)});
      _db.userCollection
          .doc(user!.id)
          .update({"following": FieldValue.increment(-1)});
    } else {
      _followed.value = true;

      _db.userCollection
          .doc(creatorId)
          .collection("followers")
          .doc(user!.id)
          .set({"follow": true});
      _db.userCollection
          .doc(user!.id)
          .collection("following")
          .doc(creatorId)
          .set({"follow": true});

      _db.userCollection
          .doc(creatorId)
          .update({"followers": FieldValue.increment(1)});
      _db.userCollection
          .doc(user!.id)
          .update({"following": FieldValue.increment(1)});
    }
  }

  Future<bool> checkSubscribed({required String? creatorId}) async {
    var subscribeRef = _db.userCollection.doc(creatorId);

    var docSnapshot =
        await subscribeRef.collection("subscriber").doc(user!.id).get();
    if (docSnapshot.exists) {
      _subscribed.value = true;
      return true;
    } else {
      _subscribed.value = false;
      return false;
    }
  }

  void setSubscribe({required String creatorId}) {
    if (subscribed) {
      _subscribed.value = false;

      _db.userCollection
          .doc(creatorId)
          .collection("subscriber")
          .doc(user!.id)
          .delete();
      _db.userCollection
          .doc(user!.id)
          .collection("subscription")
          .doc(creatorId)
          .delete();

      _db.userCollection
          .doc(creatorId)
          .update({"noOfSubscribers": FieldValue.increment(-1)});
      // _db.userCollection
      //     .doc(user!.id)
      //     .update({"noOfSubscriptions": FieldValue.increment(-1)});
    } else {
      _subscribed.value = true;

      _db.userCollection
          .doc(creatorId)
          .collection("subscriber")
          .doc(user!.id)
          .set({"subscribe": true});
      _db.userCollection
          .doc(user!.id)
          .collection("subscription")
          .doc(creatorId)
          .set({"subscription": true});

      _db.userCollection
          .doc(creatorId)
          .update({"noOfSubscribers": FieldValue.increment(1)});
      // _db.userCollection
      //     .doc(user!.id)
      //     .update({"noOfSubscriptions": FieldValue.increment(1)});
    }
  }
}
