// To parse this JSON data, do
//
//     final bookingServiceDeatilsModel = bookingServiceDeatilsModelFromJson(jsonString);

import 'dart:convert';

BookingServiceDeatilsModel bookingServiceDeatilsModelFromJson(String str) => BookingServiceDeatilsModel.fromJson(json.decode(str));

String bookingServiceDeatilsModelToJson(BookingServiceDeatilsModel data) => json.encode(data.toJson());

class BookingServiceDeatilsModel {
  int? status;
  String? message;
  Data? data;

  BookingServiceDeatilsModel({
    this.status,
    this.message,
    this.data,
  });

  factory BookingServiceDeatilsModel.fromJson(Map<String, dynamic> json) => BookingServiceDeatilsModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": data!.toJson(),
  };
}

class Data {
  String? username;
  String? userProfile;
  String? id;
  String? tblUserId;
  String? adminMasterId;
  String? bookingNo;
  String? dataServiceType;
  String? ownerName;
  String? mobileNo;
  String? bikeCc;
  String? serviceDate;
  String? slotId;
  String? brandId;
  String? vinNoPic;
  String? idProve;
  String? serviceCharge;
  String? bookingAddress;
  String? latitude;
  String? longitude;
  String? status;
  String? bookingStatus;
  String? paymentStatus;
  DateTime? addDate;
  dynamic? modifyDate;
  String? serviceType;
  String? brandName;
  int? payableAmount;
  List<PickedupImage>? pickedupImage;
  List<Image>? underServiceImage;
  List<Image>? readyDeliverImage;
  List<Image>? deliveredImage;
  List<PartsList>? partsList;
  List<TransectionList>? transectionList;

  Data({
    this.username,
    this.userProfile,
    this.id,
    this.tblUserId,
    this.adminMasterId,
    this.bookingNo,
    this.dataServiceType,
    this.ownerName,
    this.mobileNo,
    this.bikeCc,
    this.serviceDate,
    this.slotId,
    this.brandId,
    this.vinNoPic,
    this.idProve,
    this.bookingAddress,
    this.latitude,
    this.longitude,
    this.status,
    this.bookingStatus,
    this.paymentStatus,
    this.serviceCharge,
    this.addDate,
    this.modifyDate,
    this.serviceType,
    this.brandName,
    this.pickedupImage,
    this.underServiceImage,
    this.readyDeliverImage,
    this.deliveredImage,
    this.partsList,
    this.transectionList,
    this.payableAmount,
  });

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    username: json["username"]??"",
    userProfile: json["userProfile"]??"",
    id: json["id"]??"",
    tblUserId: json["tbl_user_id"]??"",
    adminMasterId: json["admin_master_id"]??"",
    bookingNo: json["booking_no"]??"",
    dataServiceType: json["service_type"]??"",
    ownerName: json["owner_name"]??"",
    mobileNo: json["mobile_no"]??"",
    bikeCc: json["bike_cc"]??"",
    serviceDate: json["service_date"]??"",
    slotId: json["slot_id"]??"",
    brandId: json["brand_id"]??"",
    vinNoPic: json["vin_no_pic"]??"",
    idProve: json["id_prove"]??"",
    serviceCharge: json["service_charge"]??"",
    bookingAddress: json["booking_address"]??"",
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"]??"",
    bookingStatus: json["booking_status"]??" ",
    paymentStatus: json["payment_status"],
    modifyDate: json["modify_date"]??" ",
    serviceType: json["serviceType"]??"",
    brandName: json["brandName"]??"",
    payableAmount: json["payable_amount"],
    pickedupImage: List<PickedupImage>.from(json["pickedup_image"].map((x) => PickedupImage.fromJson(x))),
    underServiceImage: List<Image>.from(json["under_service_image"].map((x) => Image.fromJson(x))),
    readyDeliverImage: List<Image>.from(json["ready_deliver_image"].map((x) => Image.fromJson(x))),
    deliveredImage: List<Image>.from(json["delivered_image"].map((x) => Image.fromJson(x))),
    partsList: List<PartsList>.from(json["parts_list"].map((x) => PartsList.fromJson(x))),
    transectionList: List<TransectionList>.from(json["transection_list"].map((x) => TransectionList.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "username": username,
    "userProfile": userProfile,
    "id": id,
    "tbl_user_id": tblUserId,
    "admin_master_id": adminMasterId,
    "booking_no": bookingNo,
    "service_type": dataServiceType,
    "owner_name": ownerName,
    "mobile_no": mobileNo,
    "bike_cc": bikeCc,
    "service_date": serviceDate,
    "slot_id": slotId,
    "brand_id": brandId,
    "vin_no_pic": vinNoPic,
    "id_prove": idProve,
    "service_charge": serviceCharge,
    "booking_address": bookingAddress,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "booking_status": bookingStatus,
    "payment_status": paymentStatus,
    "modify_date": modifyDate,
    "serviceType": serviceType,
    "brandName": brandName,
    "payable_amount": payableAmount,
    "pickedup_image": List<dynamic>.from(pickedupImage!.map((x) => x.toJson())),
    "under_service_image": List<dynamic>.from(underServiceImage!.map((x) => x.toJson())),
    "ready_deliver_image": List<dynamic>.from(readyDeliverImage!.map((x) => x.toJson())),
    "delivered_image": List<dynamic>.from(deliveredImage!.map((x) => x.toJson())),
    "parts_list": List<dynamic>.from(partsList!.map((x) => x.toJson())),
    "transection_list": List<dynamic>.from(transectionList!.map((x) => x.toJson())),
  };
}

class Image {
  String? id;
  String? tblUsersBookingId;
  String? image;
  String? type;
  String? status;

  Image({
    this.id,
    this.tblUsersBookingId,
    this.image,
    this.type,
    this.status,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    tblUsersBookingId: json["tbl_users_booking_id"],
    image: json["image"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tbl_users_booking_id": tblUsersBookingId,
    "image": image,
    "type": type,
    "status": status,
  };
}

class PickedupImage {
  String? id;
  String? image;

  PickedupImage({
    this.id,
    this.image,
  });

  factory PickedupImage.fromJson(Map<String, dynamic> json) => PickedupImage(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
class PartsList {
  String? id;
  String? tblUsersBookingId;
  String? parts;
  String? amount;
  String? status;
  DateTime? addDate;

  PartsList({
    this.id,
    this.tblUsersBookingId,
    this.parts,
    this.amount,
    this.status,
  });

  factory PartsList.fromJson(Map<String, dynamic> json) => PartsList(
    id: json["id"],
    tblUsersBookingId: json["tbl_users_booking_id"],
    parts: json["parts"],
    amount: json["amount"],
    status: json["status"],);

  Map<String, dynamic> toJson() => {
    "id": id,
    "tbl_users_booking_id": tblUsersBookingId,
    "parts": parts,
    "amount": amount,
    "status": status,
  };
}
class TransectionList {
  String? id;
  String? transactionId;
  String? amount;
  String? remark;
  String? status;
  String? addDate;

  TransectionList({
    this.id,
    this.transactionId,
    this.amount,
    this.remark,
    this.status,
    this.addDate,
  });

  factory TransectionList.fromJson(Map<String, dynamic> json) => TransectionList(
    id: json["id"],
    transactionId: json["transaction_id"],
    amount: json["amount"],
    remark: json["remark"],
    status: json["status"],
    addDate:json["add_date"].toString()??" ",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "amount": amount,
    "remark": remark,
    "status": status,
    "add_date": addDate,
  };
}

