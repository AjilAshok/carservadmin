import 'package:carservadmin/screens/bottomnav/bottomnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
   Registration({Key? key}) : super(key: key);

  TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final firebaseuser = _auth.currentUser;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0XFF3D433E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/1b3f3e2ac8d54e252aaf4bf798e9dbfa--motorcycle-mechanic-motorcycle-logo.jpg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                controller: name,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                
                style: TextStyle(color: Colors.white),
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF62A769)),
                  ),
                  onPressed: () async {
                    signin(_auth, name,password).then((value) {
                      if (value == null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Bottomnav()));
                      } else {
                        Center(
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                    });

                    //  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Bottomnav(),));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, letterSpacing: 1),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future signin(auth, name, password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: name.text, password: password.text);
      return null;
    } on FirebaseAuthException catch (e) {
      return print(e);
    }
  }
}
