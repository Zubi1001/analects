import 'dart:developer';

import 'package:analects/services/database_service.dart';
import 'package:analects/services/global_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../controller/user_controller.dart';

class NotificationService {
  final firestore = FirebaseFirestore.instance;
  final messaging = FirebaseMessaging.instance;
  final _globalFunctions = GlobalFunctions();
  String? get currentUid => FirebaseAuth.instance.currentUser?.uid;

  UserController get _uc => Get.find<UserController>();
  Future<bool> initializeNotificationsPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
      return true;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
      return true;
    } else {
      log('User declined or has not accepted permission');
      return false;
    }
  }

  Future<void> init() async {
    try {
      // * initialization
      if (_uc.currentUser!.allowNotification) {
        log(" uid ${currentUid.toString()}");
        if (currentUid == null) return;
        await initializeNotificationsPermissions();
        await _globalFunctions.initializeNotification();

        messaging.getToken().then(
            (token) async => await updateNotificationToken(token: token!));

        FirebaseMessaging.onMessage.listen((RemoteMessage message) async =>
            _globalFunctions.showNotification(message));

        log("Notifications initialized");
      }
    } catch (e) {
      log("Error initializing notifications");
      log(e.toString());
    }
  }

  Future<void> _createNotificationToken() async {
    String? messagingToken = await getMessagingToken();

    if (messagingToken != null) {
      await updateNotificationToken(token: messagingToken);
    }
  }

  Future<String?> getMessagingToken() async {
    log("generating messaging token");
    String? messagingToken = await messaging.getToken();
    log('messagingToken: $messagingToken');
    return messagingToken;
  }

  Future<void> subscribeToTopic({
    required String topic,
  }) async {
    try {
      // convert topic string to match regex [a-zA-Z0-9-_.~%]+
      topic = topic.replaceAll(RegExp(r'[^a-zA-Z0-9-_.~%]+'), '');
      log("subscribing to topic: $topic");
      await messaging.subscribeToTopic(topic);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> unsubscribeFromTopic({required String topic}) async {
    try {
      topic = topic.replaceAll(RegExp(r'[^a-zA-Z0-9-_.~%]+'), '');

      await messaging.unsubscribeFromTopic(topic);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  var db = DatabaseService();
  Future<void> updateNotificationToken({required String token}) async {
    try {
      if (currentUid == null) return;
      await db.userCollection.doc(currentUid).update({'fcmToken': token});
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> turnOnNotifications({
    bool isTurnOnSettings = false,
  }) async {
    await _createNotificationToken();
    if (isTurnOnSettings) {
      final user = _uc.currentUser;
      user!.allowNotification = true;
      await _uc.currentUserReference.set(user, SetOptions(merge: true));
    }

    // final listOfSettings = _nsc.notificationsSettingsList;
    // _notificationsRepo.subscribeToAllNotifications(
    //     settingsList: listOfSettings);
  }

  Future<void> turnOffNotifications({
    bool isTurnOffSettings = false,
  }) async {
    await removeFCMTokenFromFirebase();
    if (isTurnOffSettings) {
      final user = _uc.currentUser;
      user!.allowNotification = false;
      await _uc.currentUserReference.set(user, SetOptions(merge: true));
    }
    // final listOfSettings = _nsc.notificationsSettingsList;
    // await _notificationsRepo.unsubscribeFromAllNotifications(
    //     settingsList: listOfSettings);
  }

  Future<void> removeFCMTokenFromFirebase() async {
    await updateNotificationToken(token: "");
  }
}
