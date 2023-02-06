import 'package:flutter/material.dart';

class AlarmInfo {
  final DateTime alarmDateTime;
  final String? description;
  final bool isActive;
  List<Color> gradientColors;

  AlarmInfo({
    this.description,
    this.isActive = true,
    required this.alarmDateTime,
    required this.gradientColors,
  });
}
