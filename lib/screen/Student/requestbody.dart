import 'package:flutter/material.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:odapp/screen/Student/addRequest.dart';
import 'package:provider/provider.dart';
import 'package:odapp/api/studentApi.dart';
import 'package:timeline_tile/timeline_tile.dart';

String? roll_no;

class request extends StatelessWidget {
  const request({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => addrequest(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor:
            Color.fromRGBO(223, 176, 194, 1), // Change the background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              30), // Change the shape to rounded rectangle
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: validOd(),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    );
  }
}

class validOd extends StatefulWidget {
  @override
  State<validOd> createState() => _validOdState();
}

class _validOdState extends State<validOd> {
  var data;

  getCharactersfromApi(String roll) async {
    data = await api.getValidOd(roll);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, value, child) => SizedBox(
        child: FutureBuilder(
          future: getCharactersfromApi(value.roll_no),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loding.."),
              );
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TimelineTile(
                      isFirst: true,
                      isLast: true,
                      // isFirst: (index == 0) ? true : false,
                      // isLast: (index == data.length - 1) ? true : false,
                      beforeLineStyle: const LineStyle(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 30, // Adjust the width to fit the text
                        height:
                            30, // Adjust the height to increase the size of the circle
                        // color: Colors.blue,
                        padding: const EdgeInsets.all(6),
                        indicator: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Color.fromRGBO(255, 164, 130, 1),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    // Color.fromRGBO(223, 176, 194, 1),
                                    Color.fromRGBO(223, 176, 194, 1),
                                    Color.fromRGBO(183, 154, 223, 1)
                                  ])),
                          child: Center(
                            child: Text(
                              '${index + 1}', // Add 1 to start index from 1 instead of 0
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16, // Adjust the font size as needed
                              ),
                            ),
                          ),
                        ),
                      ),
                      endChild: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          elevation: 0.4,
                          child: ListTile(
                            title: Text(
                              "Reason : " + data[index]['reason'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16, // Example font size
                              ),
                            ),
                            subtitle: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text("From : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "${data[index]['start_date'].toString().substring(8, 10)}/${data[index]['start_date'].toString().substring(5, 7)}   ${data[index]['start_time'].toString().substring(0, 5)}",
                                      style: const TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14, // Example font size
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("To      : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "${data[index]['end_date'].toString().substring(8, 10)}/${data[index]['end_date'].toString().substring(5, 7)}   ${data[index]['end_time'].toString().substring(0, 5)}",
                                      style: const TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14, // Example font size
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildStatusCircle(
                                        "Class Incharge",
                                        (data[index]['class_incharge_status']
                                                    .toString() ==
                                                null)
                                            ? "Inprogress"
                                            : data[index]
                                                    ['class_incharge_status']
                                                .toString()),
                                    _buildLine(),
                                    _buildStatusCircle(
                                        "Academic Head",
                                        (data[index]['academic_head_status']
                                                    .toString() ==
                                                null)
                                            ? "Inprogress"
                                            : data[index]
                                                    ['academic_head_status']
                                                .toString()),
                                    _buildLine(),
                                    _buildStatusCircle(
                                        "HOD",
                                        (data[index]['hod_status'].toString() ==
                                                null)
                                            ? "Inprogress"
                                            : data[index]['hod_status']
                                                .toString()),
                                  ],
                                ),

                                // Row(
                                //   children: [
                                //     TimelineTile(
                                //       isFirst: true,
                                //     ),
                                //     TimelineTile(),
                                //     TimelineTile(
                                //       isLast: false,
                                //     ),
                                //     Text("Incharge : ",
                                //         style: TextStyle(color: Colors.white)),
                                //     Text(
                                //       "${(data[index]['class_incharge_status'].toString() == null) ? "Inprogress" : data[index]['class_incharge_status'].toString() ?? ""}",
                                //       style: TextStyle(
                                //         fontStyle: FontStyle.normal,
                                //         fontSize: 14, // Example font size
                                //         color: (data[index][
                                //                         'class_incharge_status']
                                //                     .toString() ==
                                //                 "rejected")
                                //             ? Colors
                                //                 .red // Set color to red if class_incharge_status is rejected
                                //             : (data[index]['class_incharge_status']
                                //                         .toString() ==
                                //                     "permitted")
                                //                 ? Colors
                                //                     .green // Set color to green if class_incharge_status is permitted
                                //                 : Colors
                                //                     .white, // Set color to white otherwise
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     Text("Academic Head : ",
                                //         style: TextStyle(color: Colors.white)),
                                //     Text(
                                //       "${(data[index]['academic_head_status'].toString() == null) ? "Inprogress" : data[index]['academic_head_status'].toString() ?? ""}",
                                //       style: TextStyle(
                                //         fontStyle: FontStyle.normal,
                                //         fontSize: 14, // Example font size
                                //         color: (data[index]
                                //                         ['academic_head_status']
                                //                     .toString() ==
                                //                 "rejected")
                                //             ? Colors
                                //                 .red // Set color to red if class_incharge_status is rejected
                                //             : (data[index]['academic_head_status']
                                //                         .toString() ==
                                //                     "permitted")
                                //                 ? Colors
                                //                     .green // Set color to green if class_incharge_status is permitted
                                //                 : Colors
                                //                     .white, // Set color to white otherwise
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     Text("Hod : ",
                                //         style: TextStyle(color: Colors.white)),
                                //     Text(
                                //       "${(data[index]['hod_status'].toString() == null) ? "Inprogress" : data[index]['hod_status'].toString() ?? ""}",
                                //       style: TextStyle(
                                //         fontStyle: FontStyle.normal,
                                //         fontSize: 14, // Example font size
                                //         color: (data[index]['hod_status']
                                //                     .toString() ==
                                //                 "rejected")
                                //             ? Colors
                                //                 .red // Set color to red if class_incharge_status is rejected
                                //             : (data[index]['hod_status']
                                //                         .toString() ==
                                //                     "permitted")
                                //                 ? Colors
                                //                     .green // Set color to green if class_incharge_status is permitted
                                //                 : Colors
                                //                     .white, // Set color to white otherwise
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            // leading: Icon(Icons.calendar_month_outlined),
                            tileColor: Color.fromRGBO(247, 245, 255, 1),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20), // Example content padding

                            shape: const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildStatusCircle(String title, String status) {
  Color color;
  int icon1;
  switch (status) {
    case "permitted":
      color = const Color.fromARGB(255, 82, 247, 87);
      icon1 = 1;
      break;
    case "rejected":
      color = const Color.fromARGB(255, 255, 17, 1);
      icon1 = 0;
      break;
    default:
      color = Colors.grey;
      icon1 = 2;
  }

  return Column(
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
            child: Icon(
          size: 18,
          (icon1 == 1)
              ? Icons.check
              : (icon1 == 0)
                  ? Icons.close
                  : Icons.circle,
        )
            // Text(
            //   title[0],
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            ),
      ),
      SizedBox(height: 4),
      Text(
        "",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _buildLine() {
  Color color;
  // int icon1;
  // switch (status) {
  //   case "permitted":
  //     color = const Color.fromARGB(255, 82, 247, 87);
  //     // icon1 = 1
  //     break;
  //   case "rejected":
  //     color = const Color.fromARGB(255, 255, 17, 1);
  //     // icon1 = 0;
  //     break;
  //   default:
  //     color = Colors.grey;
  //   // icon1 = 2;
  // }
  return Container(
    width: 50,
    height: 25,
    child: Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey,
          ),
        ),
        Container(
          width: 2,
          height: 22,
          color: const Color.fromRGBO(247, 245, 255, 1),
        ),
        Expanded(
          child: Container(
            color: const Color.fromRGBO(247, 245, 255, 1),
          ),
        ),
      ],
    ),
  );
}
