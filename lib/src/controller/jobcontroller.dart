import 'dart:convert';
import 'package:aalbaya/src/db/db.dart';
import 'package:aalbaya/src/model/job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class JobController extends GetxController {
  List<String> typeofjob = ['음식·음료', '유통·판매', '문화·여가', '기타'];
  int? jobindex;
  bool choicejobvalidate = true;
  bool dayselectedvalidate = true;
  List<String> dayofWeek = ['월', '화', '수', '목', '금', '토', '일'];
  List<bool> dayselected = [false, false, false, false, false, false, false];
  List<Map<String, dynamic>> workday = [
    {
      "월": false,
      "화": false,
      "수": false,
      "목": false,
      "금": false,
      "토": false,
      "일": false
    }
  ];
  late String daylist;

  void changejobIndex(int index) {
    jobindex = index;
    update();
  }

  void daySelected(int index) {
    dayselected[index] == false
        ? dayselected[index] = true
        : dayselected[index] = false;
    update();
  }

  void choicejobValidator() {
    jobindex == null ? choicejobvalidate = false : choicejobvalidate = true;
    update();
  }

  void dayselectedValidator() {
    dayselected.where((e) => e == false).length == 7
        ? dayselectedvalidate = false
        : dayselectedvalidate = true;

    update();
  }

  void workDay() {
    Iterable item = workday[0].keys.where((e) => workday[0][e] == true);
    daylist = jsonEncode(item.toList());
    update();
  }

  void selectedDay(int index) {
    workday[0][dayofWeek[index]] == false
        ? workday[0].update(dayofWeek[index], (value) => true)
        : workday[0].update(dayofWeek[index], (value) => false);
    update();
  }

  void addJob(Job job) {
    DatabaseHelper.instance.addJob(job);
  }
}
