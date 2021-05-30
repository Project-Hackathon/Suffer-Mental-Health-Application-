import 'package:flutter/material.dart';
import 'package:healthy_mind/providers/auth.dart';
import 'package:healthy_mind/screens/register.dart';
import 'package:healthy_mind/tabbar.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email, password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  clearTextInput() {
    email.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Image.asset('assets/brain.jpg'),
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
                    labelText: 'E-Mail',
                  ),
                ),
              ),
            ),
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
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                splashColor: Colors.white,
                child: Text(
                  'Log In',
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                height: 50,
                minWidth: 150,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  try {
                    dynamic user =
                        await Provider.of<Auth>(context, listen: false).login(
                            email.text.toString(), password.text.toString());
                    if (user['message'].toString() == "Login Successfull.") {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Tabbar()));
                      //print(user);
                    } else {
                      print(user);
                    }
                    clearTextInput();
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
                  Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  IconButton(
                      splashColor: Color(0xff5370E0),
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
