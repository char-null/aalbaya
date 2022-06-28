import 'package:aalbaya/src/controller/jobcontroller.dart';
import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(JobController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<JobController>(builder: (_) {
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
              child: FormBuilder(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    choiceJob(),
                    textFormWidget('jobname', '직장 이름', '예) 스타벅스'),
                    textFormWidget('hourlywage', '시급', '예) 9,160'),
                    firstDay(),
                    const Text(
                      '근무 시간',
                      style: headstyle,
                    ),
                    empty(),
                    Row(
                      children: [
                        workTime('attendance', '출근 시간'),
                        const SizedBox(
                          width: 10,
                        ),
                        workTime('closing', '퇴근 시간'),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
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
                            children: const [
                              Text(
                                '작성 완료',
                                style: TextStyle(
                                    color: pointcolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.check_rounded,
                                color: pointcolor,
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
      }),
    );
  }

  SizedBox empty() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget choiceJob() {
    return GetBuilder<JobController>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '직종 선택',
            style: headstyle,
          ),
          empty(),
          SizedBox(
            height: 50,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2 / 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      _.changejobIndex(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: _.jobindex == null
                            ? null
                            : _.jobindex == index
                                ? Border.all(color: pointcolor, width: 2)
                                : null,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(_.typeofjob[index], style: pointstyle),
                      ),
                    ));
              },
              itemCount: _.typeofjob.length,
            ),
          ),
        ],
      );
    });
  }

  Widget workTime(String name, String hinttext) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        child: FormBuilderDateTimePicker(
          format: DateFormat.Hm(),
          transitionBuilder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                primaryColor: pointcolor,
                colorScheme: const ColorScheme.light(
                  primary: pointcolor,
                  surface: Colors.white,
                  onSurface: pointcolor,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          },
          inputType: InputType.time,
          timePickerInitialEntryMode: TimePickerEntryMode.input,
          name: name,
          style: headstyle,
          decoration: InputDecoration(
            suffixIcon: const Icon(
              CupertinoIcons.clock,
              color: pointcolor,
            ),
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
    );
  }

  Widget firstDay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '첫 출근일',
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
          child: FormBuilderDateTimePicker(
            locale: const Locale('ko', 'KR'),
            inputType: InputType.date,
            format: DateFormat.yMMMEd('ko'),
            name: 'firstday',
            style: headstyle,
            transitionBuilder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: pointcolor,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: pointcolor,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!,
              );
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.calendar_today_rounded,
                color: pointcolor,
              ),
              suffixStyle: headstyle,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hoverColor: Colors.white,
              hintText: '예) ${DateFormat.yMMMMd('ko').format(DateTime.now())}',
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

  Widget textFormWidget(String name, String title, String hinttext) {
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
          child: FormBuilderTextField(
            name: name,
            cursorWidth: 1,
            cursorColor: Colors.black,
            style: headstyle,
            decoration: InputDecoration(
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
}
