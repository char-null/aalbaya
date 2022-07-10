import 'package:aalbaya/src/controller/jobcontroller.dart';
import 'package:aalbaya/src/controller/viewcontroller.dart';
import 'package:aalbaya/src/db/db.dart';
import 'package:aalbaya/src/model/job.dart';
import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormBuilderState>();
    final _ = Get.put(JobController());
    final viewController = Get.find<ViewController>();
    return GetBuilder<JobController>(builder: (_) {
      return Scaffold(
        backgroundColor: const Color(0xfff3f4f6),
        appBar: AppBar(
          backgroundColor: const Color(0xfff3f4f6),
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
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.08,
            ),
            child: FormBuilder(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  choiceJob(),
                  textFormWidget('detail', '세부 직종', '예) 카페', '세부 직종을 입력해주세요'),
                  textFormWidget(
                      'jobname', '직장 이름', '예) 스타벅스', '직장 이름을 입력해주세요'),
                  hourlyWage(),
                  firstDay(),
                  choiceDay(),
                  Text(
                    '근무 시간',
                    style: headstyle,
                  ),
                  empty(),
                  Row(
                    children: [
                      workTime('attendance', '출근 시간'),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      workTime('closing', '퇴근 시간'),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  InkWell(
                    onTap: () async {
                      _.choicejobValidator();
                      _.dayselectedValidator();
                      if (_formkey.currentState!.validate() &&
                          _.choicejobvalidate == true &&
                          _.dayselectedvalidate == true) {
                        _.workDay();
                        _formkey.currentState!.save();
                        final data = Map<String, dynamic>.from(
                            _formkey.currentState!.value);
                        await DatabaseHelper.instance.addJob(Job(
                            jobtype: _.typeofjob[_.jobindex!],
                            jobdetail: data['detail'],
                            jobname: data['jobname'],
                            hourlywage: int.parse((data['hourlywage'])),
                            firstday: data['firstday'].toString(),
                            workday: _.daylist,
                            attendance: data['attendance'].toString(),
                            closing: data['closing'].toString(),
                            closeday: null,
                            totalday: null,
                            totalwage: null,
                            ing: 'true'));
                        await viewController.jobData();
                        Get.back();
                        Get.snackbar(
                          '추가 완료',
                          '알바를 등록했어요',
                          snackPosition: SnackPosition.BOTTOM,
                          icon: const Icon(
                            Icons.check,
                            color: pointcolor,
                          ),
                          duration: const Duration(milliseconds: 1000),
                        );
                      }
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
    });
  }

  SizedBox empty() {
    return SizedBox(
      height: height * 0.03,
    );
  }

  Widget choiceJob() {
    final _ = Get.find<JobController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '직종 선택',
          style: headstyle,
        ),
        empty(),
        SizedBox(
          height: 50,
          child: GridView.builder(
            physics: const ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2 / 1,
              mainAxisSpacing: height,
              crossAxisSpacing: height * 0.02,
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
        _.choicejobvalidate == false
            ? const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '직종을 선택 해주세요',
                  style: TextStyle(
                      fontSize: 13,
                      color: pointcolor,
                      fontWeight: FontWeight.bold),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget choiceDay() {
    final _ = Get.find<JobController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '근무 요일',
          style: headstyle,
        ),
        empty(),
        SizedBox(
          height: height * 0.15,
          child: GridView.builder(
            physics: const ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1 / 1,
              mainAxisSpacing: height,
              crossAxisSpacing: height * 0.02,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    _.daySelected(index);
                    _.selectedDay(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: _.dayselected[index] == false
                          ? null
                          : Border.all(color: pointcolor, width: 2),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(_.dayofWeek[index], style: pointstyle),
                    ),
                  ));
            },
            itemCount: _.dayofWeek.length,
          ),
        ),
        _.dayselectedvalidate == false
            ? const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '근무 요일을 선택 해주세요',
                  style: TextStyle(
                      fontSize: 13,
                      color: pointcolor,
                      fontWeight: FontWeight.bold),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget workTime(String name, String hinttext) {
    final _ = Get.find<JobController>();
    return Expanded(
      child: FormBuilderDateTimePicker(
        validator: (val) {
          return val == null ? "시간을 입력해주세요." : null;
        },
        format: DateFormat('aa hh:mm', 'ko'),
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
        style: formbuilderstyle,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5)),
          errorStyle: pointstyle,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hoverColor: Colors.white,
          hintText: hinttext,
          hintStyle: formbuilderhintstyle,
        ),
      ),
    );
  }

  Widget firstDay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '첫 출근일',
          style: headstyle,
        ),
        empty(),
        FormBuilderDateTimePicker(
          validator: (val) {
            return val == null ? "날짜를 입력해주세요" : null;
          },
          locale: const Locale('ko', 'KR'),
          inputType: InputType.date,
          format: DateFormat.yMMMEd('ko'),
          name: 'firstday',
          style: formbuilderstyle,
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
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5)),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: const Icon(
                Icons.calendar_today_rounded,
                color: pointcolor,
              ),
              suffixStyle: headstyle,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hoverColor: Colors.white,
              hintText: '예) ${DateFormat.yMMMEd('ko').format(DateTime.now())}',
              hintStyle: formbuilderhintstyle,
              errorStyle: pointstyle),
        ),
        empty()
      ],
    );
  }

  Widget textFormWidget(
      String name, String title, String hinttext, String errortext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: headstyle,
        ),
        empty(),
        FormBuilderTextField(
          validator: FormBuilderValidators.compose([
            (val) {
              return val == null || val.isEmpty ? errortext : null;
            },
          ]),
          name: name,
          cursorWidth: 1,
          cursorColor: Colors.black,
          style: formbuilderstyle,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: pointcolor),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5)),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              errorStyle: pointstyle,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hoverColor: Colors.white,
              hintText: hinttext,
              hintStyle: formbuilderhintstyle),
        ),
        empty()
      ],
    );
  }

  Widget hourlyWage() {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '시급',
          style: headstyle,
        ),
        empty(),
        FormBuilderTextField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          validator: FormBuilderValidators.compose([
            (val) {
              return val == null || val.isEmpty ? "항목을 다 입력하지 않았어요" : null;
            },
          ]),
          name: 'hourlywage',
          cursorWidth: 1,
          cursorColor: Colors.black,
          style: formbuilderstyle,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: pointcolor),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5)),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              errorStyle: pointstyle,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hoverColor: Colors.white,
              hintText: '예) ${formatCurrency.format(9160)}',
              hintStyle: formbuilderhintstyle),
        ),
        empty()
      ],
    );
  }
}
