import 'package:flutter/material.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:provider/provider.dart';

class TeacherProfile extends StatelessWidget {
  const TeacherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
        builder: (context, value, child) => SizedBox(
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Hi ${value.email}"),
                ),
              ),
            ));
  }
}
