import 'package:flutter/material.dart';
import 'package:odapp/api/studentApi.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:odapp/screen/login.dart';
import 'package:provider/provider.dart';

TextEditingController name = TextEditingController();
TextEditingController pass = TextEditingController();
TextEditingController cpass = TextEditingController();
// TextEditingController

class details extends StatefulWidget {
  const details({Key? key}) : super(key: key);

  @override
  State<details> createState() => _detailsState();
}

String year = '2nd';
String section = 'A';

class _detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, value, child) => SizedBox(
        child: Scaffold(
          appBar: AppBar(title: Text("SignUp"), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    label: Text("Name:"),
                  ),
                ),
                TextFormField(
                  controller: pass,
                  decoration: const InputDecoration(
                    label: Text("Password"),
                  ),
                ),
                TextFormField(
                  controller: cpass,
                  decoration: const InputDecoration(
                    label: Text("Confirm Password"),
                  ),
                ),
                Row(
                  children: [
                    const Text("Year:"),
                    DropdownButton<String>(
                      // Step 3.
                      value: year,
                      // Step 4.
                      items: <String>['2nd', '3rd', '4th']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          year = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Section:"),
                    // Step 2.
                    DropdownButton<String>(
                      // Step 3.
                      value: section,
                      // Step 4.
                      items: <String>['A', 'B', 'C', 'D']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          section = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width:
                      double.infinity, // Stretch the width to fill the screen
                  color:
                      Color.fromRGBO(149, 117, 205, 1), // Set background color
                  child: ElevatedButton(
                    onPressed: () async {
                      String email = value.email;
                      String role = "Students";
                      String rlno = "";
                      for (int i = 0; i < email.length; i++) {
                        if (email[i] == '@') {
                          break;
                        } else if (RegExp(r'\d').hasMatch(email[i])) {
                          // print('${email[i]} is a digit.');
                          rlno = rlno + email[i];
                        } else {
                          role = "class_incharge";
                          break;
                        }
                      }
                      if (role == "Students") {
                        await api.createUserStudent(name.text, rlno, email,
                            pass.text, section, year, role);
                      } else {
                        await api.createUserTeacher(
                            name.text, email, pass.text, section, year, role);
                      }
                      print(role);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentLogin(),
                          ));
                    },
                    child: const Text("SignUp",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Set transparent background
                      elevation: 0, // Remove elevation
                      padding:
                          EdgeInsets.symmetric(vertical: 16.0), // Set padding
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
