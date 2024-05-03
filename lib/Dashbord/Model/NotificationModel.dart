// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  int? status;
  String? message;
  String? limit;
  int? page;
  List<Datum>? data;

  NotificationModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? mesage;
  dynamic tblUserId;
  String? adminMasterId;
  String? typeId;
  String? notiType;
  String? status;
  DateTime? addDate;

  Datum({
    this.id,
    this.mesage,
    this.tblUserId,
    this.adminMasterId,
    this.typeId,
    this.notiType,
    this.status,
    this.addDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    mesage: json["mesage"],
    tblUserId: json["tbl_user_id"],
    adminMasterId: json["admin_master_id"],
    typeId: json["type_id"],
    notiType: json["noti_type"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mesage": mesage,
    "tbl_user_id": tblUserId,
    "admin_master_id": adminMasterId,
    "type_id": typeId,
    "noti_type": notiType,
    "status": status,
    "add_date": addDate!.toIso8601String(),
  };
}
