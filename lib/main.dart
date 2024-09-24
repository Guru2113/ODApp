import 'package:flutter/material.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:odapp/screen/Student/addRequest.dart';
import 'package:odapp/screen/Student/requestbody.dart';
import 'package:odapp/screen/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => loginuid()),
    ],
    child: MaterialApp(
      initialRoute: '/',
      // Define named routes
      routes: {
        '/': (context) => StudentLogin(),
        '/other': (context) => request(),
        '/addRequest':(context) => addrequest(),
      },
      debugShowCheckedModeBanner: false,
      // home: StudentLogin(),
      // home: LocationTracker(),
    ),
  ));
}







// class LocationTracker extends StatefulWidget {
//   @override
//   _LocationTrackerState createState() => _LocationTrackerState();
// }

// class _LocationTrackerState extends State<LocationTracker> {
//   bool _isCardExtended = false;

//   void extendCard() {
//     setState(() {
//       _isCardExtended = !_isCardExtended;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Extended Card Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _isCardExtended
//                 ? Card(
//                     child: Column(
//                       children: [
//                         ListTile(
//                           title: Text('Location Status'),
//                           subtitle: Text('Location service running...'),
//                         ),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Handle button tap
//                           },
//                           child: Text('Silence Phone'),
//                         ),
//                       ],
//                     ),
//                   )
//                 : SizedBox.shrink(),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: extendCard,
//               child: Text(_isCardExtended ? 'Close Card' : 'Extend Card'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
