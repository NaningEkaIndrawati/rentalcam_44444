import 'dart:convert';

import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/helpers/user_info.dart';
import 'package:belajar/model/riwayat.dart';
import 'package:http/http.dart' as http;

class RiwayatApi {
  static Future<List<Riwayat>> getRiwayat() async {
    String apiurl = ApiUrl.riwayat;
    
    var token = await UserInfo().getToken();
  
    try {
      final response = await http.get(
        Uri.parse(apiurl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data is List) {
          List<Riwayat> riwayat =
              data.map((value) => Riwayat.fromJson(value)).toList();

          return riwayat;
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Error fetching data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to fetch data: $error');
    }
    
  }
}
