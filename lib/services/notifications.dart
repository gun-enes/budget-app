import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';
class Noti{
  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings );
  }

  static Future showBigTextNotification({var id =0,required String title, required String body,
    var payload, required FlutterLocalNotificationsPlugin fln
  } ) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
      'channel_id 6',
      'channel_name',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not= NotificationDetails(android: androidPlatformChannelSpecifics,
    );
    await fln.show(0, title, body,not );
  }
}