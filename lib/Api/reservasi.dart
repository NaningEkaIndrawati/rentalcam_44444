import 'dart:convert';
import 'dart:io';

import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/helpers/user_info.dart';
import 'package:belajar/reservasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class ReservasiApi {
  static void createReservasi(
      {String? idAlat,
      String? waktuSewa,
      String? startDate,
      String? startTime,
      String? metodePembayaran,
      File? imageFile,
      BuildContext? context}) async {
    String apiurl = ApiUrl.reservasi;

    var token = await UserInfo().getToken();

    // print("id alat : $idAlat");
    // print("waktu sewa : $waktuSewa");
    // print("start date : $startDate");
    // print("start time : $startTime");
    // return;

    try {
     var request = http.MultipartRequest('POST', Uri.parse(apiurl))
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['id_alat'] = idAlat!
      ..fields['waktu_sewa'] = waktuSewa!
      ..fields['metode_pembayaran'] = metodePembayaran!
      ..fields['start_date'] = startDate!
      ..fields['start_time'] = startTime!;

    if (imageFile != null) {
      var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('bukti_upload', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
    }

    var response = await request.send();

      if (response.statusCode == 200) {
       var responseData = await http.Response.fromStream(response);
      var jsonObj = json.decode(responseData.body);

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
       var responseData = await http.Response.fromStream(response);
      var jsonObj = json.decode(responseData.body);
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
