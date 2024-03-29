import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title ${message.notification?.title}');
    print('Body ${message.notification?.body}');
    print('Data ${message.data}');
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCMToken $fcmToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    }
}