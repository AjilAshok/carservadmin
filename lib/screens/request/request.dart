import 'package:carservadmin/screens/homescreen/viewpdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Requestpage extends StatelessWidget {
   Requestpage({Key? key}) : super(key: key);

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool acceptedregiter=true;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Request",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Color(0XFF3D433E),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Owner-Requests').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No requests'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final details = snapshot.data!.docs[index];

                return Container(
                  // color: Color.fromARGB(255, 199, 51, 51),
                  child: Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Divider(
                      //   thickness: 1,
                      //   color: Colors.black,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          details['ownername'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              " ${details['email']}",
                              // details['email'],
                              overflow: TextOverflow.visible,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          // Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0XFF62A769))),
                                onPressed: ()async {
                                await  addowner(details);

                                FirebaseFirestore.instance.collection('Owner-Requests').doc(details['ownerId']).delete();
                                  // Get.to(Trackmap());
                                },
                                child: Text(
                                  "Accept",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Phone : ${details['phonenumber']}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              details['showname'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0XFF62A769))),
                                onPressed: () {
                                  // Get.to(Trackmap());
                                },
                                child: Text(
                                  "Reject",
                                  style: TextStyle(color: Colors.black),
                                )),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          details['location'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...List.generate(
                                  details['chekbox'].length,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          '${details['chekbox'][index]}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ))
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          details['type'],
                          // "type",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 300,
                              child: Text(
                                details['proof'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                            Spacer(),
                           Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0XFF62A769))),
                                onPressed: () {
                                    // _pdfViewerKey.currentState?.openBookmarkView()
                                  
                                   Get.to(Viewpdf(index: index,));
                                },
                                child: Text(
                                  "View",
                                  style: TextStyle(color: Colors.black),
                                )),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ],
                  )),
                );
              },
            );


          }),
    ));
  }
addowner(details) async {
    
    CollectionReference usercollection =
        FirebaseFirestore.instance.collection("Owner");
    return usercollection
        .doc(details['ownerId'])
        .set({
          "ownerId":details['ownerId'],
          "showname": details['showname'],
          "phonenumber": details['phonenumber'],
          "ownername": details['ownername'],
          "email": details['email'],
          "location": details['location'],
          "type": details['type'],
          "proof": details['proof'],
          "chekbox": details['chekbox'],
          "register":acceptedregiter,
          "latitude":details['latitude'],
          "longitude":details['longitude']

        })
        .then((value) => print("accepted"))
        .onError((error, stackTrace) => print(error));
  }
}
