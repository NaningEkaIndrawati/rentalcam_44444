import 'dart:convert';

import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/camera.dart';
import 'package:http/http.dart' as http;

class KameraApi {
  static Future<List<Kamera>> getCamera() async {
    String apiurl = ApiUrl.kamera;
    print(apiurl);

    try {
      final response = await http.get(
        Uri.parse(apiurl),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        print(data);

        // Ekstrak nama produk dari data
        List<Kamera> cameras =
            data.map((camera) => Kamera.fromJson(camera)).toList();
        // print(camerax`s);
        return cameras;
      } else {
        throw Exception('error coy');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to fetch product names ${error}');
    }
  }
}
