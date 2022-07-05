// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

class Job {
  Job({
    this.id,
    required this.jobtype,
    required this.jobdetail,
    required this.jobname,
    required this.hourlywage,
    required this.firstday,
    required this.workday,
    required this.attendance,
    required this.closing,
    this.closeday,
    this.totalday,
    required this.ing,
  });

  int? id;
  String jobtype;
  String jobdetail;
  String jobname;
  int hourlywage;
  String firstday;
  String workday;
  String attendance;
  String closing;
  String? closeday;
  int? totalday;
  String ing;

  factory Job.fromMap(Map<String, dynamic> json) => Job(
        id: json["id"],
        jobtype: json["jobtype"],
        jobdetail: json["jobdetail"],
        jobname: json["jobname"],
        hourlywage: json["hourlywage"],
        firstday: json["firstday"],
        workday: json["workday"],
        attendance: json["attendance"],
        closing: json["closing"],
        closeday: json["closeday"],
        totalday: json["totalday"],
        ing: json["ing"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "jobtype": jobtype,
        "jobdetail": jobdetail,
        "jobname": jobname,
        "hourlywage": hourlywage,
        "firstday": firstday,
        "workday": workday,
        "attendance": attendance,
        "closing": closing,
        "closeday": closeday,
        "totalday": totalday,
        "ing": ing,
      };
}
