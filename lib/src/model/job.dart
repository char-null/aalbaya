// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

import 'dart:convert';

Job jobFromJson(String str) => Job.fromMap(json.decode(str));

String jobToJson(Job data) => json.encode(data.toMap());

class Job {
  Job({
    required this.jobtype,
    required this.jobdetail,
    required this.jobname,
    required this.hourlywage,
    required this.firstday,
    required this.workday,
    required this.attendance,
    required this.closing,
    required this.ing,
  });

  String jobtype;
  String jobdetail;
  String jobname;
  int hourlywage;
  String firstday;
  List<String> workday;
  String attendance;
  String closing;
  bool ing;

  factory Job.fromMap(Map<String, dynamic> json) => Job(
        jobtype: json["jobtype"],
        jobdetail: json["jobdetail"],
        jobname: json["jobname"],
        hourlywage: json["hourlywage"],
        firstday: json["firstday"],
        workday: List<String>.from(json["workday"].map((x) => x)),
        attendance: json["attendance"],
        closing: json["closing"],
        ing: json["ing"],
      );

  Map<String, dynamic> toMap() => {
        "jobtype": jobtype,
        "jobdetail": jobdetail,
        "jobname": jobname,
        "hourlywage": hourlywage,
        "firstday": firstday,
        "workday": List<dynamic>.from(workday.map((x) => x)),
        "attendance": attendance,
        "closing": closing,
        "ing": ing,
      };
}
