import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../screens/accepted/accepted.dart';

class Admincontroler extends GetxController {
  DateTimeRange range =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  late List<Gdtdate> chartdate;
  int? user;
  int? owner;
  int? total;
   int? sum;
  

  int currenindex = 0;
  bottomnavbar(index) {
    currenindex = index;
    update();
  }

  Future pickdaterange({context}) async {
    // final controler=Get.put(Admincontroler());
    DateTimeRange? newrange = await showDateRangePicker(
        context: context,
        initialDateRange: range,
        firstDate: DateTime(2021),
        lastDate: DateTime.now());
    if (newrange == null) return;
    range = newrange;
    update();
  }

  firbaseuser() async {
    user = await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((value) => value.size);
    owner = await FirebaseFirestore.instance
        .collection('Owner')
        .get()
        .then((value) => value.size);
    // print(owner);
    total = await FirebaseFirestore.instance
        .collection('Bills')
        .get()
        .then((value) => value.size);
   
    var document= await FirebaseFirestore.instance
        .collection('Bills')
        .get();

        final alldata = document.docs.map((e) => e.get('amount')).toList();
        // print(alldata);
      sum=int.parse(alldata.reduce((value, element) => value+element));   
    //  int sums=int.parse(sum);
       
     

     
   
    // print(alldata);

   
   

    update();
  }

 

}
