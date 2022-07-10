import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '설정',
          style: TextStyle(fontSize: textsize * 0.8, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: width * 0.14,
            )),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: width * 0.05,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xfff3f4f6)))),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: width * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '개인정보처리방침',
                      style: listtextstyle,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: width * 0.08,
                      color: Color(0xffB0b1b3),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const LicensePage());
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xfff3f4f6)))),
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: width * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('오픈소스 라이선스', style: listtextstyle),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: width * 0.08,
                        color: Color(0xffB0b1b3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: width * 0.05,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xfff3f4f6)))),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: width * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('데이터 백업', style: listtextstyle),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: width * 0.08,
                      color: Color(0xffB0b1b3),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xfff3f4f6)))),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: width * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('데이터 복원', style: listtextstyle),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: width * 0.08,
                      color: Color(0xffB0b1b3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: width * 0.05,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xfff3f4f6)))),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: width * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('버전 정보', style: listtextstyle),
                    Text(
                      '1.0.0',
                      style: TextStyle(
                          fontSize: textsize * 0.65,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
