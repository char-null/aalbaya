import 'package:aalbaya/src/controller/jobcontroller.dart';
import 'package:aalbaya/src/controller/viewcontroller.dart';
import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            icon: Icon(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '지난 알바',
                    style: headstyle,
                  ),
                  empty(),
                  Container(
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
                    child: Center(
                        child: Text(
                      '아직 지난 알바가 없어요!',
                      style: contentpointstyle,
                    )),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  SizedBox empty() {
    return SizedBox(
      height: 10,
    );
  }

  Widget onGoingJob(ViewController _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '진행중인 알바',
          style: headstyle,
        ),
        empty(),
        _.jobdata!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: _.jobdata!.length,
                itemBuilder: (context, index) {
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
                            Text(
                              _.jobdata![index].jobname,
                              style: headstyle,
                            ),
                            empty(),
                            Text(
                              '직종 : ${_.jobdata![index].jobdetail}',
                              style: contentstyle,
                            ),
                            Text(
                              '시급 : ${_.jobdata![index].hourlywage}',
                              style: contentstyle,
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
                child: Center(
                  child: Text('진행중인 알바가 없어요!'),
                )),
      ],
    );
  }
}
