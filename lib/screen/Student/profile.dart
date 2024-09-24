import 'package:flutter/material.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:provider/provider.dart';


class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, value, child) => SizedBox(
      child: Scaffold(
        appBar: AppBar(title: Text("Hi ${value.roll_no}"),),
      ),
    ));
  }
}