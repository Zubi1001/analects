import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/analect_model.dart';

class DatabaseService{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference get usersCollection => _firebaseFirestore.collection('users');
  CollectionReference get _analectsCollection => _firebaseFirestore.collection('analects');
  //  CollectionReference<UserModel?> get userCollection =>
  //     _usersCollection.withConverter(fromFirestore: (snapshot, options) {
  //       return snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null;
  //     }, toFirestore: (object, options) {
  //       return object!.toMap();
  //     });
    CollectionReference<AnalectModel?> get analectsCollection =>
      _analectsCollection.withConverter(fromFirestore: (snapshot, options) {
        return snapshot.exists ? AnalectModel.fromMap(snapshot.data()!) : null;
      }, toFirestore: (object, options) {
        return object!.toMap();
      });
}