import 'dart:convert';

import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/paket.dart';
import 'package:http/http.dart' as http;

class PaketApi {
  static Future<List<Paket>> getPaket() async {
    String apiurl = ApiUrl.paket;

    try {
      final response = await http.get(
        Uri.parse(apiurl),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];

        if (data is List) {
          List<Paket> paket =
              data.map((value) => Paket.fromJson(value)).toList();
          return paket;
          // return accessories;
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
