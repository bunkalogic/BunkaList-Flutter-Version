
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  

  initNotifications() async {

    await _firebaseMessaging.requestNotificationPermissions();

    final token = await _firebaseMessaging.getToken();

    print('========= FCM Token ============');
    print('token: $token');

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );

    
  }

  static Future<dynamic> onMessage(Map<String, dynamic> message) async {
    
    print('================ onMessage ================');
    print('message: $message');

  }

  static Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    
    print('================ onLaunch ================');
    print('message: $message');

  }

  static Future<dynamic> onResume(Map<String, dynamic> message) async {
    
    print('================ onResume ================');
    print('message: $message');

  }



  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }


}