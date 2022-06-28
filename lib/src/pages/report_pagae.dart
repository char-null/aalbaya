import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '진행중인 알바',
                style: headstyle,
              ),
              empty(),
              Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '스타벅스',
                          style: subheadstyle,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            '그만두기',
                            style: pointstyle,
                          ),
                        )
                      ],
                    ),
                    empty(),
                    RichText(
                      text: const TextSpan(
                          text: '직종 : ',
                          style: contentstyle,
                          children: [
                            TextSpan(
                              text: '카페',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pointcolor),
                            ),
                          ]),
                    ),
                    RichText(
                      text: const TextSpan(
                          text: '시급 : ',
                          style: contentstyle,
                          children: [
                            TextSpan(
                              text: '10,000 원',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pointcolor),
                            ),
                          ]),
                    ),
                    RichText(
                      text: const TextSpan(
                          text: '현재까지 총 근무시간 : ',
                          style: contentstyle,
                          children: [
                            TextSpan(
                              text: '800 시간',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pointcolor),
                            ),
                          ]),
                    ),
                    RichText(
                      text: const TextSpan(
                          text: '현재까지 총 수입 : ',
                          style: contentstyle,
                          children: [
                            TextSpan(
                              text: '8,000,000 원',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pointcolor),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              empty(),
              empty(),
              const Text(
                '지난 알바',
                style: headstyle,
              ),
              empty(),
              lastwork(),
              empty(),
              empty(),
              const Text(
                '통계',
                style: headstyle,
              ),
              empty(),
              Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '평가',
                      style: subheadstyle,
                    ),
                    empty(),
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(text: '대단해요! 지금까지 총 ', style: contentstyle),
                        TextSpan(text: '2개', style: contentpointstyle),
                        TextSpan(text: '의 직장에서 ', style: contentstyle),
                        TextSpan(text: '2300 시간 ', style: contentpointstyle),
                        TextSpan(text: '일했고, ', style: contentstyle),
                        TextSpan(text: '총 수입은 ', style: contentstyle),
                        TextSpan(
                            text: '21,740,000 원', style: contentpointstyle),
                        TextSpan(text: '입니다', style: contentstyle),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox empty() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget lastwork(
      // String workkname,
      // String attendance,
      // String closing,
      // String hourlywage,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '할리스',
            style: subheadstyle,
          ),
          empty(),
          RichText(
            text: const TextSpan(text: '직종 : ', style: contentstyle, children: [
              TextSpan(
                text: '카페',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: pointcolor),
              ),
            ]),
          ),
          RichText(
            text: const TextSpan(text: '시급 : ', style: contentstyle, children: [
              TextSpan(
                text: '9,160 원',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: pointcolor),
              ),
            ]),
          ),
          RichText(
            text: const TextSpan(
                text: '근무 기간 : ',
                style: contentstyle,
                children: [
                  TextSpan(
                    text: '2022-01-04 ~ 2022-06-27',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: pointcolor),
                  ),
                ]),
          ),
          RichText(
            text: const TextSpan(
                text: '총 근무시간 : ',
                style: contentstyle,
                children: [
                  TextSpan(
                    text: '1500 시간',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: pointcolor),
                  ),
                ]),
          ),
          RichText(
            text:
                const TextSpan(text: '총 수입 : ', style: contentstyle, children: [
              TextSpan(
                text: '13,740,000 원',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: pointcolor),
              ),
            ]),
          ),
          Row(
            children: const [
              Text(
                '만족도 : 4.9',
                style: contentstyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
