import 'dart:convert';
import 'package:aalbaya/src/db/db.dart';
import 'package:aalbaya/src/model/job.dart';
import 'package:aalbaya/src/pages/add_job_page.dart';
import 'package:aalbaya/src/pages/report_pagae.dart';
import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
            child: FutureBuilder<List<Job>>(
                future: DatabaseHelper.instance.getJob(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    );
                  } else {
                    return snapshot.data!.isEmpty
                        ? Column(
                            children: [
                              appBar(),
                              Center(child: Text('추가된 알바가 없어요')),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appBar(),
                              empty(),
                              todayJob(context, snapshot),
                              empty(),
                              todayInfo(context, '오늘 할일', []),
                              empty(),
                              todayInfo(context, '메뉴얼', []),
                              empty(),
                              todayWage(context, snapshot),
                              empty(),
                              todayInfo(context, '오늘의 후기', [])
                            ],
                          );
                  }
                }),
          ),
        ),
      ),
    );
  }

  SizedBox empty() {
    return const SizedBox(
      height: 15,
    );
  }

  Widget appBar() {
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

  Widget todayJob(BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
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
            '오늘 알바',
            style: headstyle,
          ),
          empty(),
          ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              List<dynamic> list = jsonDecode(snapshot.data![index].workday);
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
                        child: list.contains(DateFormat.E('ko')
                                    .format(DateTime.now())) ==
                                true
                            ? Text(
                                ' ${snapshot.data![index].jobname} ${DateFormat('HH:mm', 'ko').format((DateTime.parse(snapshot.data![index].attendance)))} ~ ${DateFormat('HH:mm', 'ko').format((DateTime.parse(snapshot.data![index].closing)))}',
                                style: contentstyle,
                              )
                            : Text(' 오늘은 휴일입니다 푹 쉬세요!'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget todayWage(BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
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
            '오늘의 일당 계산',
            style: headstyle,
          ),
          empty(),
          ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var list = jsonDecode(snapshot.data![index].workday);
              var diffence = DateTime.parse(snapshot.data![index].closing)
                  .difference(DateTime.parse(snapshot.data![index].attendance));
              var total = snapshot.data![index].hourlywage * diffence.inHours;
              return list.contains(DateFormat.E('ko').format(DateTime.now())) ==
                      true
                  ? RichText(
                      text: TextSpan(
                        text:
                            '${snapshot.data![index].hourlywage.toString()} X ${diffence.inHours} = ',
                        style: contentstyle,
                        children: [
                          TextSpan(text: '$total 원', style: contentpointstyle),
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
}
