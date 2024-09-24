import 'package:flutter/material.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:odapp/screen/Teacher/TeacherProfile.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:odapp/api/studentApi.dart';

class teacherHome extends StatefulWidget {
  const teacherHome({super.key});

  @override
  State<teacherHome> createState() => _teacherHomeState();
}

class _teacherHomeState extends State<teacherHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, value, child) => SizedBox(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Teacher"),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeacherProfile(),
                          ));
                    },
                    icon: Icon(Icons.account_circle_outlined)),
                IconButton(
                    onPressed: () {
                      value.email = "";
                      value.roll_no = "";
                      value.role = "";
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
            body: OdList()),
      ),
    );
  }
}

class OdList extends StatefulWidget {
  const OdList({super.key});

  @override
  State<OdList> createState() => _OdListState();
}

class _OdListState extends State<OdList> {
  var data;
  getod(String e1) async {
    print(e1 + "**");
    data = await api.getReqOdTeacher(e1);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, v, child) => SizedBox(
        child: FutureBuilder(
          future: getod(v.email),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loding.."),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    // print(data[index]["class_incharge_status"].toString());

                    return Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reason: ${data[index]['reason'].toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                                'Start Date: ${(data[index]['start_date']).toString().substring(0, 10)}'),
                            Text(
                                'End Date: ${(data[index]['end_date']).toString().substring(0, 10)}'),
                            SizedBox(height: 8.0),
                            Text('Start Time: ${data[index]['start_time']}'),
                            Text('End Time: ${data[index]['end_time']}'),
                            SizedBox(height: 8.0),
                            Text(
                                'Achievements: ${data[index]['achievements']}'),
                            Text(
                                "Class_Incharge:${(data[index]['class_incharge_status']).toString()}"),
                            SizedBox(height: 8.0),
                            // Text('Date: ${data['date']}'),
                            // Text('Day: ${data['day']}'),
                            SizedBox(height: 8.0),

                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      api.updateResponse(
                                          data[index]['od_id'].toString(),
                                          v.email,
                                          "1");
                                      setState(() {
                                        data = api.getReqOdTeacher(v.email);
                                      });
                                    },
                                    child: Text("Acccept")),
                                ElevatedButton(
                                    onPressed: () {
                                      api.updateResponse(
                                          data[index]['od_id'].toString(),
                                          v.email,
                                          "0");
                                      setState(() {
                                        data = api.getReqOdTeacher(v.email);
                                      });
                                    },
                                    child: Text("Reject"))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            // return Text("abc");
          },
        ),
      ),
    );
  }
}
