import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/constants/constants.dart';
import 'package:time_tracker/screens/home_screen2.dart';
import 'package:time_tracker/screens/manager/home_screen.dart';
import 'package:time_tracker/screens/signup_screen.dart';
import 'package:time_tracker/services/firestore_services.dart';

class LoginScreen extends StatefulWidget {
  final bool ismanager;
  const LoginScreen({Key? key, required this.ismanager}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  FirestoreService _firestoreService = FirestoreService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size _mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: _mediaQuery.height,
          child: SingleChildScrollView(
            child: Container(
              height: _mediaQuery.height,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: appdarkColor,
                    child: Center(
                      child: Image.asset(
                        'assets/images/GC5-imtac.png',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: _mediaQuery.height * 0.1, horizontal: 50),
                      color: applightColor,
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: email,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Username",
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextField(
                            controller:password,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Password",
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: _toggle,
                              ),
                            ),
                            obscureText: _obscureText,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>SignupScreen(ismanager: widget.ismanager,)));
                            },
                              child: Text("Don't have an accont? Signup")
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextButton(
                              child: Text("Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(15)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          appdarkColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: appdarkColor),
                                  ))),
                              onPressed: () {
                                  checkLogin(email.text,password.text,widget.ismanager);
                                  // widget.ismanager == true
                                //     ? Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (_) => HomeScreen()))
                                //     : Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (_) => HomeScreen2()));
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkLogin(String email,String password,bool isManager) async{
    var checkLogin = _firestoreService.checkLogin(email, password, isManager);
    print(checkLogin);
  }


}
