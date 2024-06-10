import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleNotification(DateTime scheduledTime, String title, String body) {
    final scheduledNotificationDateTime =
        scheduledTime.subtract(Duration(minutes: 10));
        final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
   flutterLocalNotificationsPlugin.zonedSchedule(
  0,
  title,
  body,
  tzScheduledTime,
  platformChannelSpecifics,
  uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,

);

  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});
