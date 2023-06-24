import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Category { lifeStyle, sport, routine, studying }

enum RateCount { daily, monthly, yearly }

final formatter = DateFormat.yMd();
final categoryIcon = {
  Category.sport: FontAwesomeIcons.dribbble,
  Category.lifeStyle: Icons.sports_martial_arts_sharp,
  Category.studying: Icons.book,
  Category.routine: Icons.calendar_today_outlined,
};

//import Intl
class Task {
  Task(
      {required this.category,
      required this.count,
      required this.dateTime,
      required this.title,
      required this.rateCount});
  String title;
  RateCount rateCount;
  DateTime dateTime;
  Category category;
  int count;

  get formattedDate {
    return formatter.format(dateTime);
  }
}
