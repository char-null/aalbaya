import 'package:aalbaya/src/db/db.dart';
import 'package:aalbaya/src/model/job.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ViewController extends GetxController {
  late List<Job>? jobdata;
  late List<Job>? ongoingjob;
  late List<Job>? lastjob;
  final formKey = GlobalKey<FormBuilderState>();
  late List workingday = [];
  int totalday = 0;

  Future<void> jobData() async {
    jobdata = await DatabaseHelper.instance.getJob();
    ongoingjob = jobdata!.where((e) => e.ing == 'true').toList();
    lastjob = jobdata!.where((e) => e.ing == 'false').toList();
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
