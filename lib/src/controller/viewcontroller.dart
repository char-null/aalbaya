import 'package:aalbaya/src/db/db.dart';
import 'package:aalbaya/src/model/job.dart';
import 'package:get/get.dart';

class ViewController extends GetxController {
  late List<Job>? jobdata;
  late List<Job>? ongoingjob;
  late List<Job>? lastjob;
  Future<void> jobData() async {
    jobdata = await DatabaseHelper.instance.getJob();
    update();
  }

  void ingType() {
    for (var i = 0; i < jobdata!.length; i++) {
      if (jobdata![i].ing == 'true') {
        ongoingjob![i] = jobdata![i];
        update();
      } else {
        for (var j = 0; j < jobdata!.length; j++) {
          lastjob![j] = jobdata![i];
          update();
        }
      }
    }
  }
}
