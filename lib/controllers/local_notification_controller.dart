import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../res/global.dart';

class LocalPushNotificationHelper {
  LocalPushNotificationHelper._();

  static final LocalPushNotificationHelper localPushNotificationHelper =
  LocalPushNotificationHelper._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeLocalPushNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
    const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings darwinInitializationSettings =
    const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showSimpleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      'Task',
      'Your task is scheduled...',
      priority: Priority.max,
      importance: Importance.max,
    );
    DarwinNotificationDetails darwinNotificationDetails =
    const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      'Task',
      'Your task is scheduled...',
      notificationDetails,
      payload: "Simple notification payload...",
    );
  }

  Future<void> showSimpleNotification1() async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      'Task',
      'Your task is updated...',
      priority: Priority.max,
      importance: Importance.max,
    );
    DarwinNotificationDetails darwinNotificationDetails =
    const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      'Task',
      'Your task is updated...',
      notificationDetails,
      payload: "Simple notification payload...",
    );
  }

  Future<void> showScheduledNotification() async {
    var dateTime = DateTime(Global.year,Global.month,Global.day,Global.hour,Global.minute,0);
    tz.initializeTimeZones();

    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      'Warning',
      'Your task time is near to complete...',
      priority: Priority.max,
      importance: Importance.max,
    );
    DarwinNotificationDetails darwinNotificationDetails =
    const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'Warning',
      'Your task time is near to complete...',
      tz.TZDateTime.from(dateTime,tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "Payload is working...",
    );
  }
}
