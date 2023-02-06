import 'dart:async';

import 'package:clockapp/helpers/enums.dart';
import 'package:clockapp/models/alarm_info.dart';
import 'package:clockapp/theme/theme_data.dart';

import '../models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(
    menuType: MenuType.clock,
    title: "Clock",
    imageSource: "assets/clock_icon.png",
  ),
  MenuInfo(
    menuType: MenuType.alarm,
    title: "Alarm",
    imageSource: "assets/alarm_icon.png",
  ),
  MenuInfo(
    menuType: MenuType.timer,
    title: "Timer",
    imageSource: "assets/timer_icon.png",
  ),
  MenuInfo(
    menuType: MenuType.stopwatch,
    title: "Stopwatch",
    imageSource: "assets/stopwatch_icon.png",
  ),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
    alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
    description: "Office",
    gradientColors: GradientColors.sky,
  ),
  AlarmInfo(
    alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
    description: "Sport",
    gradientColors: GradientColors.sunset,
  ),
];
