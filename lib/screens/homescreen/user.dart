import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
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
                    itemBuilder: (context, index) {
                      final details=snapshot.data!.docs[index];
                      return Container(
                          height: 150,
                          margin: EdgeInsets.all(5),
                          // color: Colors.red,
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
                              details['Name'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    details['email'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        // side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0XFF62A769))),
                                  onPressed: () {
                                    // Get.to(Trackmap());
                                  },
                                  child: Text(
                                    "Block",
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              details['phonenumber'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                            ],
                          ));
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                })));
  }
}
