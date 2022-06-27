import 'package:aalbaya/src/pages/add_task_page.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateFormat.MMMMd('ko')
                            .add_EEEE()
                            .format(DateTime.now()),
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
                ),
                empty(),
                todayInfo(context, '오늘 알바', ['스타벅스 10:00 ~ 18:00']),
                empty(),
                todayInfo(context, '오늘 할일', ['청소', '신입교육하기', '퇴근하기']),
                empty(),
                todayInfo(context, '메뉴얼', ['10분 전 출근하기', '손님 밝게 맞이하기']),
                empty(),
                todayInfo(context, '오늘의 일당 계산', [
                  '10,000 X 8 = 80,000 원',
                  '치킨(20,000원 기준) 4마리를',
                  '살 수 있는 돈을 벌었어요!'
                ]),
                empty(),
                todayInfo(context, '오늘의 후기', [
                  '손님이 반말해 가면서 주문했다. 진짜 개빡쳤음;;🤬',
                  '테이블 밑에 왜 음료를 흘려요^^ 좀 닦던가'
                ])
              ],
            ),
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
