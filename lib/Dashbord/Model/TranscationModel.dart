// To parse this JSON data, do
//
//     final transcationHistoryModel = transcationHistoryModelFromJson(jsonString);

import 'dart:convert';

TranscationHistoryModel transcationHistoryModelFromJson(String str) => TranscationHistoryModel.fromJson(json.decode(str));

String transcationHistoryModelToJson(TranscationHistoryModel data) => json.encode(data.toJson());

class TranscationHistoryModel {
  int? limit;
  int? page;
  int? totalAmount;
  int? status;
  String? message;
  List<DataDetails>? data;

  TranscationHistoryModel({
    this.limit,
    this.page,
    this.totalAmount,
    this.status,
    this.message,
    this.data,
  });

  factory TranscationHistoryModel.fromJson(Map<String, dynamic> json) => TranscationHistoryModel(
    limit: json["limit"],
    page: json["page"],
    totalAmount: json["totalAmount"],
    status: json["status"],
    message: json["message"],
    data: List<DataDetails>.from(json["Data"].map((x) => DataDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "page": page,
    "totalAmount": totalAmount,
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataDetails {
  String? id;
  String? tblUserId;
  String? adminMasterId;
  String? tblUsersBookingId;
  String? transactionId;
  String? amount;
  String? remark;
  String? status;
  String? addDate;
  String? username;
  String? userProfile;
  String? shopName;
  String? shopPhoto;
  String? bookingNo;
  String? serviceType;

  DataDetails({
    this.id,
    this.tblUserId,
    this.adminMasterId,
    this.tblUsersBookingId,
    this.transactionId,
    this.amount,
    this.remark,
    this.status,
    this.addDate,
    this.username,
    this.userProfile,
    this.shopName,
    this.shopPhoto,
    this.bookingNo,
    this.serviceType,
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) => DataDetails(
    id: json["id"],
    tblUserId: json["tbl_user_id"],
    adminMasterId: json["admin_master_id"],
    tblUsersBookingId: json["tbl_users_booking_id"],
    transactionId: json["transaction_id"],
    amount: json["amount"],
    remark: json["remark"],
    status: json["status"],
    addDate: json["add_date"],
    username: json["username"]??"",
    userProfile: json["userProfile"],
    shopName: json["shop_name"]??"",
    shopPhoto: json["shop_photo"]??"",
    bookingNo: json["booking_no"],
    serviceType: json["serviceType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tbl_user_id": tblUserId,
    "admin_master_id": adminMasterId,
    "tbl_users_booking_id": tblUsersBookingId,
    "transaction_id": transactionId,
    "amount": amount,
    "remark": remark,
    "status": status,
    "add_date": addDate,
    "username": username,
    "userProfile": userProfile,
    "shop_name": shopName,
    "shop_photo": shopPhoto,
    "booking_no": bookingNo,
    "serviceType": serviceType,
  };
}
