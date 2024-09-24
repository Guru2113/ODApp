import 'package:flutter/material.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:odapp/screen/Student/request.dart';
import 'package:odapp/screen/otpVerify.dart';
import 'package:provider/provider.dart';
import '../api/studentApi.dart';
import 'package:odapp/screen/Teacher/Teacherhome.dart';

TextEditingController usr = TextEditingController();
TextEditingController pass = TextEditingController();

TextEditingController email = TextEditingController();

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
        builder: (context, uid1, child) => SizedBox(
              child: SafeArea(
                child: Scaffold(
                  body: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(0),
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  // maxWidth: 600,
                                  ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // Ensure the column takes minimum vertical space
                                children: [
                                  Image.asset("assets/logo2 2.png"),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 15,
                                    ),
                                    child: TextFormField(
                                      controller: usr,
                                      // cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 8),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                116, 116, 116, 0.5),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(32, 1, 1, 0.498),
                                          ),
                                        ),
                                        labelText: "UserName:",
                                        labelStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                116, 116, 116, 0.5)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 15,
                                    ),
                                    child: TextFormField(
                                      controller: pass,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                116, 116, 116, 0.5),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                116, 116, 116, 0.5),
                                          ),
                                        ),
                                        labelText: "Password:",
                                        labelStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                116, 116, 116, 0.5)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      // height: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          String email = usr.text;
                                          String role = "Students";
                                          String rlno = "";
                                          for (int i = 0;
                                              i < email.length;
                                              i++) {
                                            if (email[i] == '@') {
                                              break;
                                            } else if (RegExp(r'\d')
                                                .hasMatch(email[i])) {
                                              // print('${email[i]} is a digit.');
                                              rlno = rlno + email[i];
                                            } else {
                                              role = "class_incharge";
                                              break;
                                            }
                                          }
                                          if (role == "Students") {
                                            uid1.setRole("Student");
                                            uid1.setroll_no(rlno);
                                          }

                                          print(rlno);
                                          int f = await api.login(
                                              usr.text, pass.text);
                                          if (f == 1) {
                                            uid1.setemail(email);
                                            // ignore: use_build_context_synchronously
                                            if (uid1.role == "Student") {
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const studentRequest(),
                                                ),
                                              );
                                            } else {
                                              uid1.setemail(email);
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        teacherHome(),
                                                  ));
                                            }
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Invaild login'),
                                                  content: Text(
                                                      'wrong Username or password'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        // Close the alert dialog
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(2),
                                              ),
                                            ),
                                            backgroundColor:
                                                Color.fromRGBO(99, 59, 188, 1)),
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/Group 10.png",
                                  ),
                                  // const Text("Or",
                                  //     style: TextStyle(
                                  //         color:
                                  //             Color.fromARGB(255, 0, 0, 0))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => signUp(),));
                                      _showPopup(context);
                                      // api.getData(usr.text, pass.text);
                                    },
                                    style: TextButton.styleFrom(
                                      elevation: 0,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Don’t have an account ?",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        141, 141, 153, 1))),
                                            Text(
                                              " Register",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // ),
            ));
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<loginuid>(
            builder: (context, value, child) => SizedBox(
                  child: AlertDialog(
                    title: const Text('Enter Email'),
                    content: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          label: Text("Email"),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            value.setemail(email.text);
                            await api.postEmail(email.text);
                            // ignore: use_build_context_synchronously
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => otpverify()));
                          },
                          child: const Text("verify")),
                      TextButton(
                        onPressed: () {
                          // Close the popup
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ));
      },
    );
  }
}
