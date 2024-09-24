import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:odapp/screen/Student/request.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:odapp/api/studentApi.dart';

class addrequest extends StatefulWidget {
  const addrequest({Key? key}) : super(key: key);

  @override
  State<addrequest> createState() => _addrequestState();
}

class _addrequestState extends State<addrequest> {
  TextEditingController reason = new TextEditingController();
  TextEditingController ach = new TextEditingController();
  DateTime? selectedDate;
  DateTime? selectedEndDate;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate.add(Duration(days: 1)),
      firstDate: currentDate.add(Duration(days: 1)),
      lastDate:
          currentDate.add(Duration(days: 3)), // Restrict to the next three days
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate
          .add(Duration(days: 1)), // Set initial date to the next day
      firstDate: selectedEndDate ?? currentDate,
      lastDate: DateTime(
          2101), // Allow dates up to the year 2100 (you can adjust this)
    );

    if (pickedDate != null && pickedDate != selectedEndDate) {
      setState(() {
        selectedEndDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
        builder: (context, value, child) => SizedBox(
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Add request"),
                  centerTitle: true,
                ),
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      Text("Reason"),
                      TextFormField(
                        controller: reason,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Start date:"),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: Text(selectedDate != null
                                ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'
                                : 'Select Date'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (picked != null && picked != selectedTime) {
                                setState(() {
                                  selectedTime = picked;
                                });
                              }
                            },
                            // ignore: unnecessary_null_comparison
                            child: Text(selectedTime != null
                                ? '${selectedTime.format(context)}'
                                : 'Select Time'),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text('Selected Time: ${selectedTime.format(context)}'),
                      Text("End date:"),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _selectDate1(context),
                            child: Text(selectedEndDate != null
                                ? 'End Date: ${DateFormat('yyyy-MM-dd').format(selectedEndDate!)}'
                                : 'Select End Date'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: selectedTime1,
                              );
                              if (picked != null && picked != selectedTime1) {
                                setState(() {
                                  selectedTime1 = picked;
                                });
                              }
                            },
                            // ignore: unnecessary_null_comparison
                            child: Text(selectedTime1 != null
                                ? '${selectedTime1.format(context)}'
                                : 'Select Time'),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Text('Selected Time: ${selectedTime1.format(context)}'),
                      Text("Achievement"),
                      TextFormField(
                        controller: ach,
                      ),
                      Text("Reason st-en date st-en time achiev"),

                      ElevatedButton(
                          onPressed: () async {
                            int c = 0;
                            String stdate = "";
                            String stTime = "";
                            String endTime = "";
                            if (selectedDate != null &&
                                selectedEndDate != null) {
                              stdate = DateFormat('yyyy-MM-dd')
                                  .format(selectedDate!);
                              c++;
                              // print(enddate + " " + stdate);
                            } else {}

                            // ignore: unnecessary_null_comparison
                            if (selectedTime != null && selectedTime1 != null) {
                              // stTime = selectedTime1.format(context);
                              stTime = _formatTime(selectedTime);
                              endTime = _formatTime(selectedTime1);
                              // endTime = selectedTime1.format(context);
                              // print(endTime + " " + stTime);
                              c++;
                            } else {}

                            // ignore: unnecessary_null_comparison
                            if (c == 2 &&
                                selectedDate != null &&
                                selectedEndDate != null &&
                                selectedTime != null &&
                                selectedTime1 != null) {
                              print(stdate);
                              api.applyOd(
                                  value.roll_no,
                                  reason.text,
                                  selectedEndDate!,
                                  selectedDate!,
                                  stTime,
                                  endTime,
                                  ach.text);
                              // Navigator.pop(context);
                              // Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => studentRequest(),
                                ),
                                // ModalRoute.withName('/addrequest'),
                              );
                            }
                          },
                          child: Text("Submit"))
                    ],
                  ),
                ),
              ),
            ));
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    // final second = time.periodOffset != 0 ? 'PM' : 'AM';
    return '$hour:$minute:00';
  }
}
