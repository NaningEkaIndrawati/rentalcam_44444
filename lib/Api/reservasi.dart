import 'dart:convert';

import 'package:belajar/dashboard.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/helpers/user_info.dart';
import 'package:belajar/reservasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReservasiApi {
  static void createReservasi(
      {String? idAlat,
      String? waktuSewa,
      String? startDate,
      String? startTime,
      BuildContext? context}) async {
    String apiurl = ApiUrl.reservasi;
    var token = await UserInfo().getToken();

    // print("id alat : $idAlat");
    // print("waktu sewa : $waktuSewa");
    // print("start date : $startDate");
    // print("start time : $startTime");
    // return;

    try {
      var body = {
        "id_alat": idAlat,
        "waktu_sewa": waktuSewa,
        "start_date": startDate.toString(),
        "start_time": startTime,
      };

      var response = await http.post(Uri.parse(apiurl),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body);

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);

        Navigator.pushReplacement(
            context!, MaterialPageRoute(builder: (context) => Second()));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("${jsonObj['message']}"),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        var jsonObj = json.decode(response.body);
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("${jsonObj['errors']}"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('An error occurred. Please try again later. ${e}'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
