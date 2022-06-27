import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                  '직종 선택',
                  style: headstyle,
                ),
                empty(),
                SizedBox(
                  height: 50,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 2 / 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: [
                      selectWork('음식·음료'),
                      selectWork('유통·판매'),
                      selectWork('문화·여가'),
                      selectWork('서비스'),
                    ],
                  ),
                ),
                inputInfo('직장 이름', '예) 스타벅스', null),
                inputInfo(
                  '첫 출근일',
                  '예)2022-06-27',
                  Icon(
                    Icons.calendar_today_rounded,
                    color: pointcolor,
                  ),
                ),
                Text(
                  '근무 시간',
                  style: headstyle,
                ),
                empty(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                        child: TextFormField(
                          cursorWidth: 1,
                          cursorColor: Colors.black,
                          style: headstyle,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              CupertinoIcons.clock,
                              color: pointcolor,
                            ),
                            suffixStyle: headstyle,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hoverColor: Colors.white,
                            hintText: '출근 시간',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                        child: TextFormField(
                          cursorWidth: 1,
                          cursorColor: Colors.black,
                          style: headstyle,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              CupertinoIcons.clock,
                              color: pointcolor,
                            ),
                            suffixStyle: headstyle,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hoverColor: Colors.white,
                            hintText: '퇴근 시간',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                empty(),
                inputInfo('시급', '예) 9,160', null),
                empty(),
                empty(),
                empty(),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '작성 완료',
                            style: headstyle,
                          ),
                          Icon(
                            Icons.check_rounded,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectWork(String work) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Center(
        child: Text(work, style: pointstyle),
      ),
    );
  }

  Widget inputInfo(String title, String hinttext, Icon? icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: headstyle,
        ),
        empty(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: TextFormField(
            cursorWidth: 1,
            cursorColor: Colors.black,
            style: headstyle,
            decoration: InputDecoration(
              suffixIcon: icon,
              suffixStyle: headstyle,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hoverColor: Colors.white,
              hintText: hinttext,
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
        empty()
      ],
    );
  }

  SizedBox empty() {
    return const SizedBox(
      height: 10,
    );
  }
}
