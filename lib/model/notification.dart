class Notification {
  List<Notifications>? notifications;

  Notification({this.notifications});

  Notification.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  String? notificationId;
  int? penyewaId;
  int? orderId;
  String? title;
  String? message;
  String? status;
  String? createdAt;
  String? updatedAt;

  Notifications(
      {this.id,
      this.notificationId,
      this.penyewaId,
      this.orderId,
      this.title,
      this.message,
      this.status,
      this.createdAt,
      this.updatedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationId = json['notification_id'];
    penyewaId = json['penyewa_id'];
    orderId = json['order_id'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notification_id'] = this.notificationId;
    data['penyewa_id'] = this.penyewaId;
    data['order_id'] = this.orderId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
