import 'dart:convert';
import 'package:aalbaya/src/controller/viewcontroller.dart';
import 'package:aalbaya/src/db/db.dart';
import 'package:aalbaya/src/model/job.dart';
import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(ViewController());
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        backgroundColor: const Color(0xfff3f4f6),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.08,
          ),
          child: GetBuilder<ViewController>(builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                onGoingJob(_),
                lastJob(_),
                report(_),
              ],
            );
          }),
        ),
      ),
    );
  }

  SizedBox empty() {
    return SizedBox(
      height: height * 0.03,
    );
  }

  SizedBox empty2() {
    return SizedBox(
      height: height * 0.05,
    );
  }

  Widget report(ViewController _) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    int alltotalwage = 0;
    int alltotalday = 0;
    for (var i = 0; i < _.lastjob!.length; i++) {
      alltotalwage += _.lastjob![i].totalwage!;
      alltotalday += _.lastjob![i].totalday!;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '??????',
          style: headstyle,
        ),
        empty(),
        _.lastjob!.isNotEmpty
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.08, vertical: width * 0.07),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 0.4,
                      blurRadius: 2,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: RichText(
                  text: TextSpan(
                      text: '????????????! ???????????? ??? ',
                      style: contentstyle,
                      children: [
                        TextSpan(
                          text: '${_.lastjob!.length}???',
                          style: contentpointstyle,
                        ),
                        const TextSpan(text: '??? ???????????? '),
                        TextSpan(
                            text: '$alltotalday???', style: contentpointstyle),
                        const TextSpan(text: '??? ?????????, '),
                        TextSpan(
                            text: '${formatCurrency.format(alltotalwage)} ???',
                            style: contentpointstyle),
                        const TextSpan(text: ' ????????????!')
                      ]),
                ),
              )
            : Container(
                height: height * 0.4,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.08, vertical: width * 0.07),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 0.4,
                      blurRadius: 2,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Center(
                    child: Text(
                  '????????? ???????????? ?????????!',
                  style: contentpointstyle,
                )),
              )
      ],
    );
  }

  Widget lastJob(ViewController _) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '?????? ??????',
          style: headstyle,
        ),
        empty(),
        _.lastjob!.isEmpty
            ? Column(
                children: [
                  Container(
                    height: height * 0.4,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 0.4,
                          blurRadius: 2,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                        child: Text(
                      '?????? ?????? ????????? ?????????!',
                      style: contentpointstyle,
                    )),
                  ),
                  empty2()
                ],
              )
            : ListView.builder(
                itemCount: _.lastjob!.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.08, vertical: width * 0.07),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 0.4,
                              blurRadius: 2,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _.lastjob![index].jobname,
                              style: subheadstyle,
                            ),
                            SizedBox(
                              height: width * 0.08,
                            ),
                            Text(
                              '?????? : ${_.lastjob![index].jobtype}',
                              style: contentstyle,
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Text(
                              '???????????? : ${_.lastjob![index].jobdetail}',
                              style: contentstyle,
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Text(
                              '?????? : ${formatCurrency.format(_.lastjob![index].hourlywage)} ???',
                              style: contentstyle,
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Text(
                              '???????????? : ${DateFormat('yy-MM-dd', 'ko').format(DateTime.parse(_.lastjob![index].firstday))} ~ ${DateFormat('yy-MM-dd', 'ko').format(DateTime.parse(_.lastjob![index].closeday!))}',
                              style: contentstyle,
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Text(
                              '??? ?????? : ${formatCurrency.format(_.lastjob![index].totalwage)} ???',
                              style: contentstyle,
                            ),
                          ],
                        ),
                      ),
                      empty2()
                    ],
                  );
                }),
      ],
    );
  }

  Widget onGoingJob(ViewController _) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '???????????? ??????',
          style: headstyle,
        ),
        empty(),
        _.ongoingjob!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: _.ongoingjob!.length,
                itemBuilder: (context, index) {
                  List daylist = jsonDecode(_.ongoingjob![index].workday);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.08, vertical: width * 0.07),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 0.4,
                              blurRadius: 2,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _.ongoingjob![index].jobname,
                                  style: subheadstyle,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      AlertDialog(
                                        backgroundColor:
                                            const Color(0xfff3f4f6),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('???????????? ??????',
                                                style: subheadstyle),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            FormBuilder(
                                              key: _.formKey,
                                              child: FormBuilderDateTimePicker(
                                                validator: (val) {
                                                  return val == null
                                                      ? "????????? ??????????????????"
                                                      : null;
                                                },
                                                format: DateFormat(
                                                    'yy-MM-dd', 'ko'),
                                                inputType: InputType.date,
                                                name: 'closeday',
                                                style: formbuilderstyle,
                                                decoration: InputDecoration(
                                                    errorBorder:
                                                        const OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 2,
                                                                color:
                                                                    pointcolor)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    errorStyle: pointstyle,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    hintText: DateFormat(
                                                            'yy-MM-dd', 'ko')
                                                        .format(
                                                      DateTime.now(),
                                                    ),
                                                    hintStyle:
                                                        formbuilderhintstyle),
                                              ),
                                            ),
                                          ],
                                        ),
                                        buttonPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                        actions: [
                                          GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                '??????',
                                                style: contentpointstyle,
                                              )),
                                          GestureDetector(
                                              onTap: () async {
                                                if (_.formKey.currentState!
                                                    .validate()) {
                                                  _.formKey.currentState!
                                                      .save();
                                                  var total = DateTime.parse(_
                                                          .formKey
                                                          .currentState!
                                                          .value['closeday']
                                                          .toString())
                                                      .difference(
                                                          DateTime.parse(_
                                                              .ongoingjob![
                                                                  index]
                                                              .firstday));
                                                  _.totalDay(
                                                      jsonDecode(_
                                                          .ongoingjob![index]
                                                          .workday),
                                                      total.inDays,
                                                      DateTime.parse(_
                                                          .ongoingjob![index]
                                                          .firstday));
                                                  await DatabaseHelper.instance.updatecloseJob(
                                                      Job(
                                                          id: _
                                                              .ongoingjob![
                                                                  index]
                                                              .id,
                                                          jobtype: _
                                                              .ongoingjob![
                                                                  index]
                                                              .jobtype,
                                                          jobdetail: _
                                                              .ongoingjob![
                                                                  index]
                                                              .jobdetail,
                                                          jobname: _
                                                              .ongoingjob![
                                                                  index]
                                                              .jobname,
                                                          hourlywage: _
                                                              .ongoingjob![
                                                                  index]
                                                              .hourlywage,
                                                          firstday: _
                                                              .ongoingjob![
                                                                  index]
                                                              .firstday,
                                                          workday: _
                                                              .ongoingjob![
                                                                  index]
                                                              .workday,
                                                          attendance: _
                                                              .ongoingjob![
                                                                  index]
                                                              .attendance,
                                                          closing: _
                                                              .ongoingjob![
                                                                  index]
                                                              .closing,
                                                          closeday: _
                                                              .formKey
                                                              .currentState!
                                                              .value['closeday']
                                                              .toString(),
                                                          totalday: _.totalday,
                                                          totalwage: _.totalday *
                                                              _
                                                                  .ongoingjob![
                                                                      index]
                                                                  .hourlywage *
                                                              DateTime.parse(_
                                                                      .ongoingjob![index]
                                                                      .closing)
                                                                  .difference(DateTime.parse(_.ongoingjob![index].attendance))
                                                                  .inHours,
                                                          ing: 'false'),
                                                      _.ongoingjob![index].id);
                                                  _.jobData();
                                                  Get.back();
                                                  Get.snackbar(
                                                    '?????? ?????? ??????',
                                                    '????????? ??????????????????!',
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    icon: const Icon(
                                                      Icons.check,
                                                      color: pointcolor,
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 1000),
                                                  );
                                                }
                                              },
                                              child: Text(
                                                '??????',
                                                style: contentpointstyle,
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '????????????',
                                    style: pointstyle,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: width * 0.08,
                            ),
                            Text(
                              '?????? ?????? : ${DateFormat('yy-MM-dd', 'ko').format(DateTime.parse(_.ongoingjob![index].firstday))} ~ ',
                              style: contentstyle,
                            ),
                            Text(
                              '?????? : ${_.ongoingjob![index].jobdetail}',
                              style: contentstyle,
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Text(
                              '?????? : ${formatCurrency.format(_.ongoingjob![index].hourlywage)} ???',
                              style: contentstyle,
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Text(
                              '???????????? ?????? : ${formatCurrency.format(_.ongoingjob![index].hourlywage)} ???',
                              style: contentstyle,
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  '?????? ?????? : ',
                                  style: contentstyle,
                                ),
                                for (var e in daylist)
                                  Text(
                                    '$e ',
                                    style: contentstyle,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      empty2(),
                    ],
                  );
                })
            : Column(
                children: [
                  Container(
                    height: height * 0.4,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.08, vertical: width * 0.07),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 0.4,
                          blurRadius: 2,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '???????????? ????????? ?????????!',
                        style: contentpointstyle,
                      ),
                    ),
                  ),
                  empty2(),
                ],
              ),
      ],
    );
  }
}
