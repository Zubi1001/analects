import 'package:analects/app/modules/widgets/widget_imports.dart';

class DatabaseService{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference get usersCollection => _firebaseFirestore.collection('users');
  CollectionReference get analectsCollection => _firebaseFirestore.collection('analects');
  //  CollectionReference<UserModel?> get userCollection =>
  //     _usersCollection.withConverter(fromFirestore: (snapshot, options) {
  //       return snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null;
  //     }, toFirestore: (object, options) {
  //       return object!.toMap();
  //     });
}