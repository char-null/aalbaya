import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class JobController extends GetxController {
  TimeOfDay? time;
  final formkey = GlobalKey<FormBuilderState>();
  List<String> typeofjob = ['음식·음료', '유통·판매', '문화·여가', '기타'];
  int? jobindex;

  changeTime(TimeOfDay newTime) {
    time = newTime;
    update();
  }

  changejobIndex(int index) {
    jobindex = index;
    update();
  }
}
