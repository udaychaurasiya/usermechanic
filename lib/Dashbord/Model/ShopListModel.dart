// To parse this JSON data, do
//
//     final shopListModel = shopListModelFromJson(jsonString);

import 'dart:convert';

ShopListModel shopListModelFromJson(String str) => ShopListModel.fromJson(json.decode(str));

String shopListModelToJson(ShopListModel data) => json.encode(data.toJson());

class ShopListModel {
  int? status;
  String? message;
  String? limit;
  int? page;
  List<Datum> data;

  ShopListModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    required this.data,
  });

  factory ShopListModel.fromJson(Map<String, dynamic> json) => ShopListModel(
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
  String? categoryId;
  String? userLogin;
  String? adminMasterId;
  String? name;
  String? shopName;
  String? email;
  String? mobile;
  String? password;
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
  String? idProvePhoto;
  String? normalCcByck;
  String? heighPickup;
  String? byckServiceCapicity;
  String? storeTime;
  String? shopPhoto;
  String? deviceId;
  String? fcmId;
  String? otp;
  String? regBy;
  String? status;
  DateTime? addDate;
  dynamic? categoryTitle;
  String? stateTitle;
  String? cityName;
  String? selectVehicle;
  String? rating;
  String? noRating;
  String? distance;

  Datum({
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
    this.selectVehicle,
    this.byckServiceCapicity,
    this.storeTime,
    this.shopPhoto,
    this.deviceId,
    this.fcmId,
    this.otp,
    this.regBy,
    this.status,
    this.addDate,
    this.categoryTitle,
    this.stateTitle,
    this.cityName,
    this.rating,
    this.noRating,
    this.distance,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryId: json["category_id"],
    userLogin: json["user_login"],
    adminMasterId: json["admin_master_id"],
    name: json["name"]??"",
    shopName: json["shop_name"]??"Unknown",
    email: json["email"],
    mobile: json["mobile"],
    password: json["password"],
    type: json["type"],
    profile: json["profile"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    zipCode: json["zip_code"],
    address: json["address"],
    description: json["description"],
    latitude: json["latitude"]??"",
    longitude: json["longitude"]??"",
    mapAddress: json["map_address"]??"",
    isOnRoadService: json["is_on_road_service"],
    idProveType: json["id_prove_type"],
    idProveNo: json["id_prove_no"],
    idProvePhoto: json["id_prove_photo"],
    normalCcByck: json["normal_cc_byck"],
    heighPickup: json["heigh_pickup"],
    selectVehicle: json["select_vehicle"]??"Two Wheeler",
    byckServiceCapicity: json["byck_service_capicity"],
    storeTime: json["store_time"],
    shopPhoto: json["shop_photo"],
    deviceId: json["device_id"],
    fcmId: json["fcm_id"],
    otp: json["otp"],
    regBy: json["reg_by"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    categoryTitle: json["categoryTitle"],
    stateTitle: json["state_title"],
    cityName: json["city_Name"],
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
