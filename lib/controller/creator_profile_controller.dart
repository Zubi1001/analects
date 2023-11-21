import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/analect_model.dart';

class CreatorProfileController extends GetxController {
  final user = Get.find<UserController>().currentUser;
   final _creatorAnalectList = Rx<List<AnalectModel?>>([]);
  //  final _topCreatorAnalectList = Rx<List<UserModel?>>([]);

  List<AnalectModel?> get analectList => _creatorAnalectList.value;
  // List<UserModel?> get topCreatorList => _topCreatorAnalectList.value;
  final _db = DatabaseService();


  Stream<List<AnalectModel?>> _creatorsAnalects() {
    return _db.analectsCollection.where("creatorId", isEqualTo: user!.id)
        .snapshots()
        .map((event) {
          log("event  is ${event.docs.length}");
          return event.docs.map((e) => e.data()).toList();
        });
  }
  
  // Stream<List<UserModel?>> _topCreators() {
  //   return _db.userCollection.where("creator", isEqualTo: true)
  //       .snapshots()
  //       .map((event) {
  //         log("event  is ${event.docs.length}");
  //         return event.docs.map((e) => e.data()).toList();
  //       });
  // }

  @override
  void onInit() {
    // _topCreatorAnalectList.bindStream(_topCreators());
    _creatorAnalectList.bindStream(_creatorsAnalects());
    super.onInit();
  }
 
 @override
  void onClose() {
    // _topCreatorAnalectList.close();
    _creatorAnalectList.close();
    super.onClose();
  }
}