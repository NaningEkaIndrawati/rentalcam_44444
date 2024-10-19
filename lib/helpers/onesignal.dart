import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalHelper{
  Future<void> setOneSignalByUserID(int userID) async {
    // Mengatur externalUserId di OneSignal
    await OneSignal.login(userID.toString());
  }
}