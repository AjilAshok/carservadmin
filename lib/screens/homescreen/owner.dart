import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Owner extends StatelessWidget {
  const Owner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Owner').snapshots(),
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
                      final ownerdetails = snapshot.data!.docs[index];
                      return
                          // Container(
                          //     height: MediaQuery.of(context).size.height * 0.4,
                          //     margin: EdgeInsets.all(5),
                          //     // color: Colors.red,
                          //     child:
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Divider(
                          //   thickness: 1,
                          //   color: Colors.black,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                          ownerdetails['ownername'],
                          style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Row(
                            children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                ownerdetails['email'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width*0.6
                          // ),
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
                          ownerdetails['phonenumber'],
                          style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                          ownerdetails['showname'],
                          style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                          ownerdetails["type"],
                          style: TextStyle(fontSize: 20),
                            ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                          ownerdetails['location'],
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
                                  ownerdetails['chekbox'].length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10),
                                        child: Text(
                                          '${ownerdetails['chekbox'][index]}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ))
                            ],
                          ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ],
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                })));
  }
}
