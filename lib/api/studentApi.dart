import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class api {
  static var baseurl = "http://192.168.68.30/api/";

  static login(String usr, String pass) async {
    var url = Uri.parse("${baseurl}login");

    final res = await http.post(url, body: {"email": usr, "pass": pass});

    try {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
        return 1;
      } else {
        print("failed to connect");
        return 0;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  static postEmail(String email1) async {
    var url = Uri.parse(baseurl + "verify1");
    print(url);
    print(email1);

    // Print the request body before sending
    // print({"email": email1});

    final res1 = await http.post(url, body: {"email": email1});

    try {
      if (res1.statusCode == 200) {
        var data = jsonDecode(res1.body.toString());
        print(data);
      } else {
        print(res1.statusCode);
        print("failed to connect" + res1.body.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getOtpVerify(String email1, String otp) async {
    // print(email1);
    var url = Uri.parse(baseurl + "verify");
    print(url);
    print(email1);
    final res1 = await http.post(url, body: {"email": email1, "code": otp});
    try {
      if (res1.statusCode == 200) {
        var data = jsonDecode(res1.body.toString());
        print(data);
        return data;
      } else {
        print(res1.statusCode);
        print("failed to connect");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //createUserStudent
  static createUserStudent(String name, String rlno, String email1, String pass,
      String? section, String? Year, String role) async {
    // print(email1);
    var url = Uri.parse(baseurl + "createUser");
    print(url);
    print(email1);
    final res1 = await http.post(url, body: {
      "name": name,
      "roll_no": rlno,
      "email": email1,
      "pass": pass,
      "dept": "CSE",
      "year": Year,
      "section": section,
      "role": role
    });
    try {
      if (res1.statusCode == 200) {
        var data = jsonDecode(res1.body.toString());
        print(data);
        return data;
      } else {
        print(res1.statusCode);
        print("failed to connect");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //createUserTeacher
  static createUserTeacher(String name, String email1, String pass,
      String? section, String? Year, String role) async {
    // print(email1);
    var url = Uri.parse(baseurl + "createUser");
    print(url);
    print(email1);
    final res1 = await http.post(url, body: {
      "name": name,
      "email": email1,
      "pass": pass,
      "dept": "CSE",
      "year": Year,
      "section": section,
      "role": role
    });
    try {
      if (res1.statusCode == 200) {
        var data = jsonDecode(res1.body.toString());
        print(data);
        return data;
      } else {
        print(res1.statusCode);
        print("failed to connect");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //applyOD

  static applyOd(String rollno, String reason, DateTime stdate,
      DateTime enddate, String startTime, String endtime, String ach) async {
    // print(stdate + "jdbj");
    Map<String, dynamic> jsonData = {
      "roll_no": rollno,
      "reason": reason,
      "start_date": stdate.toIso8601String(),
      "end_date": enddate.toIso8601String(),
      "start_time": startTime,
      "end_time": endtime,
      "achievements": ach
      // Add more key-value pairs as needed
    };
    String jsonEncoded = json.encode(jsonData);
    var url = Uri.parse(baseurl + "createOnduty");
    print(url);
    final res1 = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncoded);
    try {
      print(res1.statusCode);
      if (res1.statusCode == 200) {
        var data = jsonDecode(res1.body.toString());
        print(data);
        // return data;
      } else if (res1.statusCode == 502) {
        var data = jsonDecode(res1.body.toString());
        print(data);
      } else {
        var data = jsonDecode(res1.body.toString());
        print(data);
        print(res1.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //home or valid od
  static Future<List<dynamic>> getValidOd(String rollno) async {
    var url = Uri.parse(baseurl + "validOD");
    print(url);
    final res1 = await http.post(url, body: {"roll_no": rollno});
    try {
      if (res1.statusCode == 200) {
        List<dynamic> data = jsonDecode(res1.body.toString());
        print(data);
        return data; // Return the decoded data instead of the response object
      } else {
        print(res1.statusCode);
        print("failed to connect");
        // Return an empty list or any default value in case of failure
        return []; // You can modify this to return any default value as needed
      }
    } catch (e) {
      print(e.toString());
      // Return an empty list or any default value in case of an error
      return []; // You can modify this to return any default value as needed
    }
  }
  // static Future getValidOd(String rollno) async {
  //   var url = Uri.parse(baseurl + "validOD");
  //   print(url);
  //   final res1 = await http.post(url, body: {"roll_no": rollno});
  //   try {
  //     if (res1.statusCode == 200) {
  //       List data = jsonDecode(res1.body.toString());
  //       print(data);
  //       return res1;
  //     } else {
  //       print(res1.statusCode);
  //       print("failed to connect");
  //       // Return an empty string or any default value in case of failure
  //       return res1; // You can modify this to return any default value as needed
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     // Return an empty string or any default value in case of an error
  //     return res1; // You can modify this to return any default value as needed
  //   }
  // }

  //history
  static Future gethistory(String rollno) async {
    var url = Uri.parse(baseurl + "history");
    print(url);
    final res1 = await http.post(url, body: {"roll_no": rollno});
    try {
      if (res1.statusCode == 200) {
        List data = jsonDecode(res1.body.toString());
        print(data);
        return data;
      } else {
        print(res1.statusCode);
        print("failed to connect");
        // Return an empty string or any default value in case of failure
        return res1; // You can modify this to return any default value as needed
      }
    } catch (e) {
      print(e.toString());
      // Return an empty string or any default value in case of an error
      return res1; // You can modify this to return any default value as needed
    }
  }

  static Future getReqOdTeacher(String email) async {
    Map<String, dynamic> jsonData = {
      "email": email,
      // Add more key-value pairs as needed
    };
    String jsonEncoded = json.encode(jsonData);
    var url = Uri.parse(baseurl + "classincharge/ods");
    print(url);
    print(email);
    final res1 = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncoded);
    try {
      if (res1.statusCode == 200) {
        List data = jsonDecode(res1.body.toString());
        print(res1.body.toString());
        print(data);
        return data;
      } else {
        print(res1.statusCode);
        print("failed to connect");
        // Return an empty string or any default value in case of failure
        return res1; // You can modify this to return any default value as needed
      }
    } catch (e) {
      print(e.toString());
      // Return an empty string or any default value in case of an error
      return res1; // You can modify this to return any default value as needed
    }
  }

  static updateResponse(String id, String email, String status) async {
    var url = Uri.parse(baseurl + "updater");
    print(url);
    final res1 = await http
        .post(url, body: {"email": email, "od_id": id, "status": status});
    try {
      if (res1.statusCode == 200) {
        List data = jsonDecode(res1.body.toString());
        print(data);
        return data;
      } else {
        print(res1.statusCode);
        print("failed to connect");
        // Return an empty string or any default value in case of failure
        return res1; // You can modify this to return any default value as needed
      }
    } catch (e) {
      print(e.toString());
      // Return an empty string or any default value in case of an error
      return res1; // You can modify this to return any default value as needed
    }
  }
}
