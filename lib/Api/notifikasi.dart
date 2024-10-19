import 'dart:convert';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/helpers/user_info.dart';
// import 'package:belajar/model/app_notification.dart'; // Ubah nama model
import 'package:belajar/model/notification.dart';
import 'package:http/http.dart' as http;

class NotifikasiApi {
  static Future<List<Notifications>> getNotification() async {
    String apiurl = ApiUrl.notifikasi;

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

        // Extract the 'notifications' list from the response
        if (data is Map<String, dynamic> && data.containsKey('notifications')) {
          List<dynamic> notificationsJson = data['notifications'];
          
          // Convert the dynamic list into a List of Notifications objects
          List<Notifications> notifications = notificationsJson
              .map((value) => Notifications.fromJson(value))
              .toList();

          return notifications;
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Error fetching data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to fetch data: $error');
    }
  }
}
