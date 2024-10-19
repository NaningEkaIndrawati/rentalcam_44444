import 'dart:convert';
import 'dart:io';
import 'package:belajar/dashboard.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/helpers/onesignal.dart';
import 'package:belajar/helpers/user_info.dart';
import 'package:belajar/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  static Future<void> login(
      {String? email, String? password, BuildContext? context}) async {
    String apiurl = ApiUrl.login;

    try {
      var body = {"email": email, "password": password};
      var response = await http.post(Uri.parse(apiurl), body: body);

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        UserInfo().setToken(jsonObj['token']);
        OneSignalHelper().setOneSignalByUserID(jsonObj['user']['id']);
        Navigator.pushReplacement(
          context!,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );

        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text("Berhasil Login"),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  static Future<void> register({
    String? name,
    String? email,
    String? password,
    String? alamat,
    String? telepon,
    File? imageFile,
    BuildContext? context,
  }) async {
    String apiurl = ApiUrl.registrasi;
    print(imageFile);

    try {
      if (imageFile == null || !imageFile.existsSync()) {
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text('Image file is missing or invalid.'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(apiurl));
      request.headers['Content-Type'] = 'application/json'; // Add this lin
      request.fields.addAll({
        'nama': name!,
        'email': email!,
        'password': password!,
        'alamat': alamat!,
        'telepon': telepon!,
      });

      request.files.add(
        http.MultipartFile(
          'ktp', // Nama parameter yang diharapkan oleh API
          imageFile!.readAsBytes().asStream(),
          imageFile!.lengthSync(),
          filename: imageFile!.path.split('/').last,
          // contentType: http.('image', 'jpeg'), // Sesuaikan dengan jenis gambar yang diunggah
        ),
      );
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var jsonObj = json.decode(responseBody);

        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text(jsonObj['message']),
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.pushReplacement(
          context!,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        var jsonObj = json.decode(responseBody);
        print(jsonObj);
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text(jsonObj['error'] ?? 'An error occurred.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later. $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
