// To parse this JSON data, do
//
//     final shopDeatilsModel = shopDeatilsModelFromJson(jsonString);

import 'dart:convert';

ShopDeatilsModel shopDeatilsModelFromJson(String str) => ShopDeatilsModel.fromJson(json.decode(str));

String shopDeatilsModelToJson(ShopDeatilsModel data) => json.encode(data.toJson());

class ShopDeatilsModel {
  int? status;
  String? message;
  Ankit? data;

  ShopDeatilsModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShopDeatilsModel.fromJson(Map<String, dynamic> json) => ShopDeatilsModel(
    status: json["status"],
    message: json["message"],
    data: Ankit.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": data!.toJson(),
  };
}

class Ankit {
  String? id;
  String? categoryId;
  String? userLogin;
  String? adminMasterId;
  String? name;
  String? shopName;
  String? email;
  String? mobile;
  dynamic password;
  String? type;
  String? profile;
  String? stateId;
  String? cityId;
  String? zipCode;
  String? address;
  String? description;
  String? latitude;
  String? longitude;
  String? mapAddress;
  String? isOnRoadService;
  String? idProveType;
  String? idProveNo;
  dynamic idProvePhoto;
  String? normalCcByck;
  String? heighPickup;
  String? byckServiceCapicity;
  String? storeTime;
  String? shopPhoto;
  String? deviceId;
  String? fcmId;
  String? otp;
  String? regBy;
  String? shopOpen;
  String? status;
  DateTime? addDate;
  dynamic categoryTitle;
  String? stateTitle;
  dynamic cityName;
  dynamic rating;
  String? noRating;
  String? distance;

  Ankit({
    this.id,
    this.categoryId,
    this.userLogin,
    this.adminMasterId,
    this.name,
    this.shopName,
    this.email,
    this.mobile,
    this.password,
    this.type,
    this.profile,
    this.stateId,
    this.cityId,
    this.zipCode,
    this.address,
    this.description,
    this.latitude,
    this.longitude,
    this.mapAddress,
    this.isOnRoadService,
    this.idProveType,
    this.idProveNo,
    this.idProvePhoto,
    this.normalCcByck,
    this.heighPickup,
    this.byckServiceCapicity,
    this.storeTime,
    this.shopPhoto,
    this.deviceId,
    this.fcmId,
    this.otp,
    this.regBy,
    this.shopOpen,
    this.status,
    this.addDate,
    this.categoryTitle,
    this.stateTitle,
    this.cityName,
    this.rating,
    this.noRating,
    this.distance,
  });

  factory Ankit.fromJson(Map<String, dynamic> json) => Ankit(
    id: json["id"],
    categoryId: json["category_id"],
    userLogin: json["user_login"],
    adminMasterId: json["admin_master_id"],
    name: json["name"]??"",
    shopName: json["shop_name"]??"",
    email: json["email"]??"",
    mobile: json["mobile"]??"",
    password: json["password"],
    type: json["type"],
    profile: json["profile"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    zipCode: json["zip_code"],
    address: json["address"]??"",
    description: json["description"]??"",
    latitude: json["latitude"]??"",
    longitude: json["longitude"]??"",
    mapAddress: json["map_address"]??"",
    isOnRoadService: json["is_on_road_service"]??"",
    idProveType: json["id_prove_type"]??"",
    idProveNo: json["id_prove_no"]??"",
    idProvePhoto: json["id_prove_photo"]??"",
    normalCcByck: json["normal_cc_byck"]??"",
    heighPickup: json["heigh_pickup"]??"",
    byckServiceCapicity: json["byck_service_capicity"]??"",
    storeTime: json["store_time"]??"",
    shopPhoto: json["shop_photo"]??"",
    deviceId: json["device_id"]??"",
    fcmId: json["fcm_id"]??"",
    otp: json["otp"]??"",
    regBy: json["reg_by"]??"",
    shopOpen: json["shop_open"]??"",
    status: json["status"]??"",
    addDate: DateTime.parse(json["add_date"]),
    categoryTitle: json["categoryTitle"]??"",
    stateTitle: json["state_title"]??"",
    cityName: json["city_Name"]??"",
    rating: json["rating"]??"No Rating",
    noRating: json["no_rating"]??"",
    distance: json["distance"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "user_login": userLogin,
    "admin_master_id": adminMasterId,
    "name": name,
    "shop_name": shopName,
    "email": email,
    "mobile": mobile,
    "password": password,
    "type": type,
    "profile": profile,
    "state_id": stateId,
    "city_id": cityId,
    "zip_code": zipCode,
    "address": address,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "map_address": mapAddress,
    "is_on_road_service": isOnRoadService,
    "id_prove_type": idProveType,
    "id_prove_no": idProveNo,
    "id_prove_photo": idProvePhoto,
    "normal_cc_byck": normalCcByck,
    "heigh_pickup": heighPickup,
    "byck_service_capicity": byckServiceCapicity,
    "store_time": storeTime,
    "shop_photo": shopPhoto,
    "device_id": deviceId,
    "fcm_id": fcmId,
    "otp": otp,
    "reg_by": regBy,
    "shop_open": shopOpen,
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "categoryTitle": categoryTitle,
    "state_title": stateTitle,
    "city_Name": cityName,
    "rating": rating,
    "no_rating": noRating,
    "distance": distance,
  };
}
