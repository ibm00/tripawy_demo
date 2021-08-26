import 'package:awesome_notifications/awesome_notifications.dart';

class Notifications {
  static Future<void> creatSchedualNotification({
    int? id,
    DateTime? tripDateAndTime,
    String? tripName,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'schudualed-channel',
        title: '${Emojis.transport_air_airplane}',
        body: "It's time for your $tripName flight!!",
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'mark-done', label: 'Mark Done'),
      ],
      schedule: NotificationCalendar.fromDate(
        date: tripDateAndTime!,
      ), /* NotificationCalendar(
        month: tripDateAndTime!.month,
        weekday: tripDateAndTime.weekday,
        hour: tripDateAndTime.hour,
        minute: tripDateAndTime.minute,
        second: 0,
        millisecond: 0,
        // repeats: true,
      ) */
    );
  }

  static Future<void> modifySchedualedNotification({
    int? id,
    DateTime? newTripDateAndTime,
    String? tripName,
  }) async {
    await cancelSchedualedNotification(id!);
    await creatSchedualNotification(
      id: id,
      tripDateAndTime: newTripDateAndTime,
      tripName: tripName,
    );
  }

  static Future<void> cancelSchedualedNotification(int id) async {
    await AwesomeNotifications().cancelSchedule(id);
  }
}
