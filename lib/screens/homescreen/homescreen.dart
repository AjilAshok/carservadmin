import 'package:carservadmin/screens/homescreen/owner.dart';
import 'package:carservadmin/screens/homescreen/user.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF3D433E),
          bottom: TabBar(
              overlayColor: MaterialStateProperty.all(Color(0XFF3D433E)),
              indicatorColor: Color.fromARGB(255, 190, 221, 13),
              tabs: const [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "User",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text("Owner", style: TextStyle(fontSize: 20))
              ]),
        ),
        body: TabBarView(children: [
          User(),
          Owner(),
        ]),
      ),
    ));
  }
}
