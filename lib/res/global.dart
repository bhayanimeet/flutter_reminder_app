import 'package:flutter/material.dart';
import '../models/sqlite_db_model.dart';

class Global{
  static bool isDark = false;
  static bool isVisited = false;
  static bool isLogged = false;
  static late Future<List<Task>> allTask;
  static late List<Task>? data;

  static TextEditingController taskController = TextEditingController();
  static TextEditingController titleController = TextEditingController();
  static TextEditingController dateController = TextEditingController();
  static TextEditingController startTimeController = TextEditingController();
  static TextEditingController endTimeController = TextEditingController();
  static TextEditingController reminderController = TextEditingController();

  static String? title;
  static String? task;
  static String? myDate;
  static String? startTime;
  static String? endTime;
  static String? reminder;
  static int isCompleted = 0;

  static DateTime picker = DateTime.now();
  static int day = DateTime.now().day;
  static int month = DateTime.now().month;
  static int year = DateTime.now().year;
  static int hour = DateTime.now().hour;
  static int minute = DateTime.now().minute;
}