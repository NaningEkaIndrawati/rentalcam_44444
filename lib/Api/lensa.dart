import 'dart:convert';

import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/lensa.dart'; // Import your lensa model
import 'package:http/http.dart' as http;

class LensaApi {
  static Future<Lensa> getLensa() async {
    String apiurl =
        ApiUrl.lensa; // Assuming ApiUrl.lensa is defined in your code
    print(apiurl);

    try {
      final response = await http.get(
        Uri.parse(apiurl),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);

        // Convert the JSON data into Lensa model
        Lensa lensa = Lensa.fromJson(data);
        return lensa;
      } else {
        throw Exception('Error fetching data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to fetch data: $error');
    }
  }
}
