import 'dart:convert';
import 'package:aalbaya/src/controller/viewcontroller.dart';
import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(ViewController());
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: backgroundcolor,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: GetBuilder<ViewController>(builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onGoingJob(_),
              lasJob(_),
            ],
          );
        }),
      ),
    );
  }

  SizedBox empty() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget lasJob(ViewController _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '지난 알바',
          style: headstyle,
        ),
        empty(),
        _.lastjob!.isEmpty
            ? Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                child: const Center(
                    child: Text(
                  '아직 지난 알바가 없어요!',
                  style: contentpointstyle,
                )),
              )
            : ListView.builder(
                itemCount: _.lastjob!.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _.lastjob![index].jobname,
                          style: headstyle,
                        ),
                        empty(),
                        Text(
                          '직종 : ${_.lastjob![index].jobdetail}',
                          style: contentstyle,
                        ),
                        Text(
                          '시급 : ${_.lastjob![index].hourlywage}',
                          style: contentstyle,
                        ),
                      ],
                    ),
                  );
                }),
      ],
    );
  }

  Widget onGoingJob(ViewController _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '진행중인 알바',
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _.ongoingjob![index].jobname,
                                  style: headstyle,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text(
                                          '그만두기',
                                          style: TextStyle(),
                                        ),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('그만두는 날짜'),
                                            FormBuilder(
                                              key: _.formKey,
                                              child: FormBuilderDateTimePicker(
                                                validator: (val) {
                                                  return val == null
                                                      ? "날짜를 입력해주세요"
                                                      : null;
                                                },
                                                format: DateFormat(
                                                    'yy-MM-dd', 'ko'),
                                                inputType: InputType.date,
                                                name: 'close',
                                                decoration: InputDecoration(
                                                  hintText: DateFormat(
                                                          'yy-MM-dd', 'ko')
                                                      .format(
                                                    DateTime.now(),
                                                  ),
                                                  hintStyle: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                  ),
                                                ),
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
                                                '취소',
                                                style: contentpointstyle,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                if (_.formKey.currentState!
                                                    .validate()) {
                                                  _.formKey.currentState!
                                                      .save();
                                                  print(_.formKey.currentState!
                                                      .value);
                                                }
                                              },
                                              child: Text(
                                                '확인',
                                                style: contentpointstyle,
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '그만두기',
                                    style: pointstyle,
                                  ),
                                )
                              ],
                            ),
                            empty(),
                            Text(
                              '직종 : ${_.ongoingjob![index].jobdetail}',
                              style: contentstyle,
                            ),
                            Text(
                              '시급 : ${_.ongoingjob![index].hourlywage}',
                              style: contentstyle,
                            ),
                            Row(
                              children: [
                                const Text(
                                  '근무 요일 : ',
                                  style: contentstyle,
                                ),
                                for (var e in daylist)
                                  Text(
                                    '$e ',
                                    style: contentstyle,
                                  ),
                                Text(
                                  '(주 ${daylist.length}일)',
                                  style: contentstyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      empty(),
                      empty(),
                    ],
                  );
                })
            : Container(
                height: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                child: const Center(
                  child: const Text('진행중인 알바가 없어요!'),
                )),
      ],
    );
  }
}
