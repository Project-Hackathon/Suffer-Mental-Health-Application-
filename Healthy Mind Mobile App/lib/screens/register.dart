import 'package:flutter/material.dart';
import 'package:healthy_mind/providers/auth.dart';
import 'package:healthy_mind/screens/login.dart';
import 'package:healthy_mind/tabbar.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name, email, number, password;

  @override
  void initState() {
    name = TextEditingController();
    email = TextEditingController();
    number = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    number.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('assets/brain.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.people),
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'E-mail',
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Container(
            //     child: TextFormField(
            //       controller: number,
            //       keyboardType: TextInputType.number,
            //       decoration: InputDecoration(
            //         prefixIcon: Icon(Icons.phone),
            //         alignLabelWithHint: true,
            //         fillColor: Colors.white,
            //         filled: true,
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(12),
            //           ),
            //         ),
            //         labelText: 'Contact Number',
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: TextFormField(
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                splashColor: Colors.white,
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                height: 50,
                minWidth: 150,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  try {
                    dynamic user =
                        await Provider.of<Auth>(context, listen: false)
                            .register(email.text.toString(),
                                password.text.toString(), name.text.toString());
                    if (user['message'].toString() == 'Registered!') {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Tabbar()));
                    }
                  } catch (err) {
                    print(err);
                  }
                },
                color: Color(0xff5370E0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "back_next",
                    child: IconButton(
                        padding: EdgeInsets.all(5),
                        color: Colors.black,
                        splashColor: Color(0xff5370E0),
                        iconSize: 30,
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SignIn",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
