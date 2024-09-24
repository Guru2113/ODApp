import 'package:flutter/material.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:provider/provider.dart';
import 'package:odapp/api/studentApi.dart';

class studenthistory extends StatefulWidget {
  const studenthistory({Key? key}) : super(key: key);

  @override
  State<studenthistory> createState() => _studenthistoryState();
}

class _studenthistoryState extends State<studenthistory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, value, child) => SizedBox(
          child: Scaffold(
        body: historyTile(),
      )),
    );
  }
}

class historyTile extends StatefulWidget {
  const historyTile({super.key});

  @override
  State<historyTile> createState() => _historyTileState();
}

class _historyTileState extends State<historyTile> {
  var data;
  gethistory(String roll) async {
    data = await api.gethistory(roll);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, value, child) => SizedBox(
        child: FutureBuilder(
          future: gethistory(value.roll_no),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loding.."),
              );
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
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
                          Text('Achievements: ${data[index]['achievements']}'),
                          SizedBox(height: 8.0),
                          // Text('Date: ${data['date']}'),
                          // Text('Day: ${data['day']}'),
                          SizedBox(height: 8.0),
                          Text(
                              'Class Incharge Status: ${data[index]['class_incharge_status'] ?? 'N/A'}'),
                          Text(
                              'Academic Head Status: ${data[index]['academic_head_status'] ?? 'N/A'}'),
                          Text(
                              'HOD Status: ${data[index]['hod_status'] ?? 'N/A'}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            // return Text("abc");
          },
        ),
      ),
    );
  }
}
