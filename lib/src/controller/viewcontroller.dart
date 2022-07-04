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
  Future<void> jobData() async {
    jobdata = await DatabaseHelper.instance.getJob();
    ongoingjob = jobdata!.where((e) => e.ing == 'true').toList();
    lastjob = jobdata!.where((e) => e.ing == 'false').toList();
    update();
  }
}
