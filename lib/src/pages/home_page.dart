import 'dart:convert';
import 'dart:ui';
import 'package:aalbaya/src/controller/viewcontroller.dart';
import 'package:aalbaya/src/db/db.dart';
import 'package:aalbaya/src/model/job.dart';
import 'package:aalbaya/src/pages/add_job_page.dart';
import 'package:aalbaya/src/pages/report_page.dart';
import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(ViewController());
    return GetBuilder<ViewController>(builder: (_) {
      return Scaffold(
        backgroundColor: backgroundcolor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: FutureBuilder<List<Job>>(
                  future: DatabaseHelper.instance.getJob(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Job>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      );
                    } else {
                      return _.ongoingjob!.isEmpty
                          ? Column(
                              children: [
                                appBar(),
                                Container(
                                  height: Get.mediaQuery.size.height * 0.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '진행중인 알바가 없어요',
                                        style: pointstyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appBar(),
                                empty(),
                                todayJob(_),
                                empty(),
                                _.todaylist!.isNotEmpty
                                    ? Column(
                                        children: [
                                          menual(_),
                                          empty(),
                                          todayWage(_),
                                          empty(),
                                        ],
                                      )
                                    : Container()
                              ],
                            );
                    }
                  }),
            ),
          ),
        ),
      );
    });
  }

  SizedBox empty() {
    return const SizedBox(
      height: 15,
    );
  }

  Widget appBar() {
    final _ = Get.put(ViewController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(DateFormat.MMMMd('ko').add_EEEE().format(DateTime.now()),
            style: headstyle),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => const AddTaskPage());
              },
              child: const Icon(Icons.add_rounded),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const ReportPage());
              },
              child: const Icon(CupertinoIcons.doc_text),
            ),
          ],
        ),
      ],
    );
  }

  Widget todayJob(ViewController _) {
    return Container(
      height: _.ongoingjob!.isEmpty ? 150 : null,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '오늘 알바',
            style: headstyle,
          ),
          empty(),
          _.todaylist!.isNotEmpty
              ? ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _.todaylist!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    width: 3,
                                    color: pointcolor,
                                  ),
                                ),
                              ),
                              child: Text(
                                ' ${_.todaylist![index].jobname} ${DateFormat('HH:mm', 'ko').format((DateTime.parse(_.todaylist![index].attendance)))} ~ ${DateFormat('HH:mm', 'ko').format((DateTime.parse(_.todaylist![index].closing)))}',
                                style: contentstyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    );
                  })
              : Container(
                  child: Text(' 오늘은 휴일입니다 푹 쉬세요!'),
                ),
        ],
      ),
    );
  }

  Widget todayWage(ViewController _) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
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
            '오늘의 일당 계산',
            style: headstyle,
          ),
          empty(),
          ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _.todaylist!.length,
            itemBuilder: (context, index) {
              var diffence = DateTime.parse(_.todaylist![index].closing)
                  .difference(DateTime.parse(_.todaylist![index].attendance));
              int total = _.todaylist![index].hourlywage * diffence.inHours;
              return _.todaylist!.isNotEmpty
                  ? RichText(
                      text: TextSpan(
                        text:
                            '${formatCurrency.format(_.todaylist![index].hourlywage)} X ${diffence.inHours} = ',
                        style: contentstyle,
                        children: [
                          TextSpan(
                              text: '${formatCurrency.format(total)} 원',
                              style: contentpointstyle),
                          TextSpan(
                              text: '\n치킨(20,000원 기준) ', style: contentstyle),
                          TextSpan(
                              text: '${(total / 20000)} 마리',
                              style: contentpointstyle),
                          TextSpan(
                              text: '를 살 수 있는 돈을 벌었어요!', style: contentstyle),
                        ],
                      ),
                    )
                  : Text('오늘은 휴일!');
            },
          ),
        ],
      ),
    );
  }

  Widget todayInfo(
    BuildContext context,
    String title,
    List<String> content,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 0.4,
            blurRadius: 2,
            offset: const Offset(0, 4),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headstyle,
          ),
          empty(),
          ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: content.length,
            itemBuilder: (context, index) {
              return Text(
                content[index],
                style: contentstyle,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget menual(ViewController _) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '메뉴얼',
                style: headstyle,
              ),
              GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FormBuilder(
                                  key: _.formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _.manualindex = 1;
                                              _.manual.clear();
                                              _.todaylistindex = null;
                                              _.todaylistvalidate = true;
                                              Get.back();
                                            },
                                            child: Icon(Icons.close),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text('오늘 알바 목록',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          empty(),
                                          GetBuilder<ViewController>(
                                              builder: (_) {
                                            return GridView.builder(
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                childAspectRatio: 2 / 1,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                              ),
                                              physics: ScrollPhysics(),
                                              itemCount: _.todaylist!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      _.todayListSelected(
                                                          index);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: _.todaylistindex ==
                                                                null
                                                            ? null
                                                            : _.todaylistindex ==
                                                                    index
                                                                ? Border.all(
                                                                    color:
                                                                        pointcolor,
                                                                    width: 2)
                                                                : null,
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            _.todaylist![index]
                                                                .jobname,
                                                            style: pointstyle),
                                                      ),
                                                    ));
                                              },
                                            );
                                          }),
                                          _.todaylistvalidate == false
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 8),
                                                  child: Text(
                                                    '알바를 선택해주세요',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: pointcolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              : Container(),
                                          empty(),
                                        ],
                                      ),
                                      Text('메뉴얼',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      empty(),
                                      ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _.manualindex,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: FormBuilderTextField(
                                                      validator:
                                                          FormBuilderValidators
                                                              .compose([
                                                        (val) {
                                                          return val == null ||
                                                                  val.isEmpty
                                                              ? '입력을 해주세요'
                                                              : null;
                                                        },
                                                      ]),
                                                      name: 'manual${[
                                                        index + 1
                                                      ]}',
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        errorStyle: pointstyle,
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        hoverColor:
                                                            Colors.white,
                                                        hintStyle: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      _.manualindex == index + 1
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                _.addMaunal();
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color:
                                                                    pointcolor,
                                                              ),
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      index > 0
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                _.deleteManual(
                                                                    'manual${[
                                                                  index + 1
                                                                ]}');
                                                              },
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    pointcolor,
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  child: Text(
                                    '추가',
                                    style: pointstyle,
                                  ),
                                  onPressed: () async {
                                    _.todaylistValdator();
                                    if (_.formKey.currentState!.validate() &&
                                        _.todaylistvalidate == true) {
                                      _.formKey.currentState!.save();
                                      for (var i = 1; i <= _.manualindex; i++) {
                                        _.manual.add(_.formKey.currentState!
                                            .value["manual[$i]"]);
                                      }
                                      await DatabaseHelper.instance
                                          .updatecloseJob(
                                        Job(
                                            id: _.todaylist![_.todaylistindex!]
                                                .id,
                                            jobtype: _
                                                .todaylist![_.todaylistindex!]
                                                .jobtype,
                                            jobdetail: _
                                                .todaylist![_.todaylistindex!]
                                                .jobdetail,
                                            jobname: _
                                                .todaylist![_.todaylistindex!]
                                                .jobname,
                                            hourlywage: _
                                                .todaylist![_.todaylistindex!]
                                                .hourlywage,
                                            firstday: _
                                                .todaylist![_.todaylistindex!]
                                                .firstday,
                                            workday: _
                                                .todaylist![_.todaylistindex!]
                                                .workday,
                                            attendance: _
                                                .todaylist![_.todaylistindex!]
                                                .attendance,
                                            closing: _
                                                .todaylist![_.todaylistindex!]
                                                .closing,
                                            closeday: _
                                                .todaylist![_.todaylistindex!]
                                                .closeday,
                                            totalday: _
                                                .todaylist![_.todaylistindex!]
                                                .totalday,
                                            totalwage: _
                                                .todaylist![_.todaylistindex!]
                                                .totalwage,
                                            manual: jsonEncode(_.manual),
                                            ing: 'true'),
                                        _.todaylist![_.todaylistindex!].id,
                                      );
                                      Get.back();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        isDismissible: false,
                        backgroundColor: backgroundcolor,
                        enableDrag: false);
                  },
                  child: Icon(Icons.add)),
            ],
          ),
          empty(),
          GetBuilder<ViewController>(builder: (_) {
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: _.todaylist!.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 3),
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(width: 3, color: pointcolor))),
                      child: Text(
                        _.todaylist![index].jobname,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    jsonDecode(_.todaylist![index].manual.toString()) != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount:
                                jsonDecode(_.todaylist![index].manual!).length,
                            itemBuilder: (context, i) {
                              return Text(
                                  jsonDecode(_.todaylist![index].manual!)[i]
                                      .toString());
                            })
                        : Container(),
                  ],
                );
              },
            );
          })
        ],
      ),
    );
  }
}
