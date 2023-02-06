import 'package:clockapp/data/data.dart';
import 'package:clockapp/main.dart';
import 'package:clockapp/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Alarm",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontFamily: "avenir",
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map((alarm) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: alarm.gradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: alarm.gradientColors.last.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.label,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                alarm.description!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "avenir",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: true,
                            onChanged: (val) {},
                            activeColor: Colors.white,
                          )
                        ],
                      ),
                      Text(
                        "Mon-Fri",
                        style: TextStyle(fontFamily: "avenir"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat("hh:mm aa").format(alarm.alarmDateTime),
                            style: const TextStyle(
                              fontFamily: "avenir",
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 36,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).followedBy(
                [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColors.clockBG,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextButton(
                      onPressed: scheduleAlarm,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/add_alarm.png",
                            scale: 1.5,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Add Alarm",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "avenir"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).toList(),
            ),
          )
        ],
      ),
    );
  }

  void scheduleAlarm() async {
    var scheduleNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 10));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // if (isRepeating)
    //   await flutterLocalNotificationsPlugin.showDailyAtTime(
    //     0,
    //     'Office',
    //     alarmInfo.title,
    //     Time(
    //       scheduledNotificationDateTime.hour,
    //       scheduledNotificationDateTime.minute,
    //       scheduledNotificationDateTime.second,
    //     ),
    //     platformChannelSpecifics,
    //   );
    // else
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Office',
      "Good morning! Time for office!",
      tz.TZDateTime.from(scheduleNotificationDateTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
