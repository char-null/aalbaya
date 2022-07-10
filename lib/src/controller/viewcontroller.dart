import 'dart:convert';
import 'package:aalbaya/src/db/db.dart';
import 'package:aalbaya/src/model/job.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewController extends GetxController {
  late List<Job>? jobdata;
  List<Job>? ongoingjob;
  List<Job>? lastjob;
  final formKey = GlobalKey<FormBuilderState>();
  late List workingday = [];
  late List<Job>? todaylist = [];
  int totalday = 0;
  List manual = [];
  int manualindex = 1;
  int? todaylistindex;
  bool todaylistvalidate = true;

  @override
  void onInit() async {
    super.onInit();
    await jobData();
  }

  Future<void> jobData() async {
    jobdata = await DatabaseHelper.instance.getJob();
    ongoingjob = jobdata!.where((e) => e.ing == 'true').toList();
    lastjob = jobdata!.where((e) => e.ing == 'false').toList();
    todaylist = ongoingjob!.where((e) {
      List test = jsonDecode(e.workday);
      return test.contains(DateFormat.E('ko').format(DateTime.now()));
    }).toList();
    update();
  }

  void todaylistDecode(int index) {
    manual = jsonDecode(todaylist![index].manual!);
    update();
  }

  void addMaunal() {
    manualindex++;

    update();
  }

  void todaylistValdator() {
    todaylistindex == null
        ? todaylistvalidate = false
        : todaylistvalidate = true;
    update();
  }

  void deleteManual(String name) {
    manualindex--;
    update();
  }

  void todayListSelected(int index) {
    todaylistindex = index;
    update();
  }

  void totalDay(List workday, int differenceday, DateTime firstday) {
    for (var e in workday) {
      switch (e) {
        case '월':
          workingday.add(1);
          break;
        case '화':
          workingday.add(2);
          break;
        case '수':
          workingday.add(3);
          break;
        case '목':
          workingday.add(4);
          break;
        case '금':
          workingday.add(5);
          break;
        case '토':
          workingday.add(6);
          break;
        case '일':
          workingday.add(7);
          break;
      }
    }
    for (var i = 0; i <= differenceday; i++) {
      var date = firstday.add(Duration(days: i));
      for (var j = 0; j < workingday.length; j++) {
        if (date.weekday == workingday[j]) {
          totalday++;
        }
      }
    }
  }
}
