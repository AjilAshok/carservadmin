import 'package:carservadmin/controler/admincontroler.dart';

import 'package:carservadmin/screens/homescreen/homescreen.dart';

import 'package:carservadmin/screens/request/request.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../accepted/accepted.dart';

class Bottomnav extends StatelessWidget {
  Bottomnav({Key? key}) : super(key: key);
  final contoler=Get.put(Admincontroler());
  final pages = [Homescreen(), Requestpage(), Report()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 249, 249),
      body: GetBuilder<Admincontroler>(
          builder: (controller) => pages[controller.currenindex]),
      bottomNavigationBar: GetBuilder<Admincontroler>(
        builder: (controller) => BottomNavigationBar(

            //  backgroundColor: Colors.black,
            currentIndex: controller.currenindex,
            unselectedFontSize: 10,
            selectedFontSize: 15,
            unselectedItemColor: Color.fromARGB(255, 31, 30, 30),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            elevation: 0,
            onTap: (index) {
              controller.bottomnavbar(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Request",
                icon: Icon(FontAwesomeIcons.screwdriver),
              ),
              BottomNavigationBarItem(
                label: "Report",
                icon: Icon(FontAwesomeIcons.copy),
              )
            ]),
      ),
    ));
  }
}
