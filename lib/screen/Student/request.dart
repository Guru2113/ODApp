import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:odapp/screen/Student/history.dart';
import 'package:odapp/screen/Student/profile.dart';
import 'package:odapp/screen/Student/requestbody.dart';
import 'package:odapp/screen/login.dart';
import 'package:provider/provider.dart';

int i = 0;

class studentRequest extends StatefulWidget {
  const studentRequest({Key? key}) : super(key: key);

  @override
  State<studentRequest> createState() => _studentRequestState();
}

class _studentRequestState extends State<studentRequest> {
  @override
  Widget build(BuildContext context) {
    final Screen = [request(), studenthistory()];
    final app_text = ["Requested", "History"];
    return Consumer<loginuid>(
      builder: (context, value, child) => SizedBox(
        child: Scaffold(
          // backgroundColor: Colors.deepPurple,
          bottomNavigationBar: CurvedNavigationBar(
              color: Color.fromRGBO(183, 154, 223, 1),
              // buttonBackgroundColor: Color.fromRGBO(255, 164, 130, 1),

              backgroundColor: Colors.transparent,
              index: i,
              onTap: (index) {
                setState(() {
                  i = index;
                });
              },
              items: const [
                Icon(
                  Icons.request_page_rounded,
                ),
                Icon(Icons.history)
              ]),
          appBar: AppBar(
            title: Text(app_text[i]),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentProfile(),
                        ));
                  },
                  icon: Icon(Icons.account_circle_outlined)),
              IconButton(
                  onPressed: () {
                    value.email = "";
                    value.roll_no = "";
                    value.role = "";
                    Navigator.pop(context);
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => StudentLogin(),
                    //     ),
                    //     ModalRoute.withName('/'));
                  },
                  icon: Icon(Icons.logout)),
            ],
          ),
          body: Screen[i],
        ),
      ),
    );
  }
}
