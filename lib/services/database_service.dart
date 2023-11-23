import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/analect_model.dart';
import 'package:analects/models/creator_subscription_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference get _userCollection =>
      _firebaseFirestore.collection('users');
  CollectionReference get _analectsCollection =>
      _firebaseFirestore.collection('analects');
  CollectionReference get _creatorSubscriptionCollection =>
      _firebaseFirestore.collection('creator_subscription');
  CollectionReference<UserModel?> get userCollection =>
      _userCollection.withConverter(fromFirestore: (snapshot, options) {
        return snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null;
      }, toFirestore: (object, options) {
        return object!.toMap();
      });
  CollectionReference<AnalectModel?> get analectsCollection =>
      _analectsCollection.withConverter(fromFirestore: (snapshot, options) {
        return snapshot.exists ? AnalectModel.fromMap(snapshot.data()!) : null;
      }, toFirestore: (object, options) {
        return object!.toMap();
      });

  CollectionReference<CreatorSubscrptionModel?>
      get creatorSubscriptionCollection => _creatorSubscriptionCollection
              .withConverter(fromFirestore: (snapshot, options) {
            return snapshot.exists
                ? CreatorSubscrptionModel.fromMap(snapshot.data()!)
                : null;
          }, toFirestore: (object, options) {
            return object!.toMap();
          });
}
