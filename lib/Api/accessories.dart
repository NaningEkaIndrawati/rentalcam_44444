import 'dart:convert';

import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/accessories.dart'; // Import your accessories model
import 'package:belajar/model/aksesoris.dart';
import 'package:http/http.dart' as http;

class AccessoriesApi {
  static Future<List<Aksesoris>> getAccessories() async {
    String apiurl = ApiUrl.accessories;

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
          List<Aksesoris> accessories =
              data.map((value) => Aksesoris.fromJson(value)).toList();
          return accessories;
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
