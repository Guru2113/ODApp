import 'package:flutter/material.dart';
import 'package:odapp/provider/dart/login.dart';
import 'package:odapp/screen/signUpdetails.dart';
import 'package:provider/provider.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../api/studentApi.dart';

class otpverify extends StatefulWidget {
  const otpverify({Key? key}) : super(key: key);

  @override
  State<otpverify> createState() => _otpverifyState();
}

class _otpverifyState extends State<otpverify> {
  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
        builder: (context, value, child) => SizedBox(
              child: Scaffold(
                appBar:
                    AppBar(title: Text("OTP Verification"), centerTitle: true),
                body: Center(
                  child: Column(
                    children: [
                      Text("We texted you a OTP to your Email",
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 30),
                      OtpTextField(
                          numberOfFields: 7,
                          borderColor: Colors.black,
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            //handle validation or checks here
                          },
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) async {
                            print(verificationCode);
                            // String responseJson =
                            Map<String, dynamic> responseData = await api
                                .getOtpVerify(value.email, verificationCode);
                            print(responseData['message']);
                            if (responseData['message'] == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => details(),
                                  ));
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Incorrect OTP'),
                                    content: Text(
                                        'The entered OTP is incorrect. Please try again.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          // Close the alert dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                            );
                          }
                          }, // end onSubmit
                          )
                    ],
                  ),
                ),
              ),
            ));
  }
}
