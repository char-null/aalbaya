import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class JobController extends GetxController {
  final formkey = GlobalKey<FormBuilderState>();
  List<String> typeofjob = ['음식·음료', '유통·판매', '문화·여가', '기타'];
  int? jobindex;
  bool choicejobvalidate = true;
  bool dayselectedvalidate = true;
  List<String> dayofWeek = ['월', '화', '수', '목', '금', '토', '일'];
  List<bool> dayselected = [false, false, false, false, false, false, false];

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
    // var j = 0;
    // for (var i = 0; i < dayselected.length; i++) {
    //   if (dayselected[i] == true) {
    //     j++;
    //   }
    // }
    // j > 0 ? dayselectedvalidate = true : dayselectedvalidate = false;
    dayselected.where((e) => e == false).length == 7
        ? dayselectedvalidate = false
        : dayselectedvalidate = true;
    update();
  }
}
