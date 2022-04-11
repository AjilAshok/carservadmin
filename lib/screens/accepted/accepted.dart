import 'package:carservadmin/controler/admincontroler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart';

class Report extends StatelessWidget {
  Report({Key? key}) : super(key: key);

  String date = "";

  DateTime selectedDate = DateTime.now();
  DateTime selectedDate1 = DateTime.now();
  

  @override
  Widget build(BuildContext context) {
    final controler = Get.put(Admincontroler());
    controler.firbaseuser();
   
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0XFF3D433E),
        title:
            Text("Report", style: TextStyle(color: Colors.white, fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<Admincontroler>(
          
          builder: (controller) => Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                series: <CircularSeries>[
                  DoughnutSeries<Gdtdate, String>(
                      dataSource: [
                        Gdtdate(content: "Total", gdp:controler.total ),
                        Gdtdate(content: "User", gdp: controler.user),
                        Gdtdate(content: "Owner", gdp: controller.owner),
                        Gdtdate(content: "Revenue", gdp: controler.sum)
                      ],
                      xValueMapper: (Gdtdate data, _) => data.content,
                      yValueMapper: (Gdtdate data, _) => data.gdp,
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(onPressed: (){
                  //   DateFormat('dd-MM-yyy').format(selectedDate);
                    
                  //   print( DateFormat('dd-MM-yyy').format(selectedDate));
                  // }, icon: Icon(Icons.abc)),
                  Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                // side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0XFF62A769))),
                          onPressed: () {
                            controler.pickdaterange(context: context);
                          },
                          child: GetBuilder<Admincontroler>(
                              builder: (controller) => Text(
                                    '${controller.range.start.day}/${controller.range.start.month}/${controller.range.start.year}',
                                    style: TextStyle(color: Colors.black),
                                  )))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                // side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0XFF62A769))),
                          onPressed: () {
                            controler.pickdaterange(context: context);
                          },
                          child: Text(
                              '${controller.range.end.day}/${controller.range.end.month}/${controller.range.end.year}',
                              style: TextStyle(color: Colors.black)))),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Gdtdate {
  Gdtdate({required this.content, required this.gdp});

  final String? content;
  final int? gdp;
}
