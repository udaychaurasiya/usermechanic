// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  int? status;
  String? message;
  List<BannerDatum>? data;

  BannerModel({
    this.status,
    this.message,
    this.data,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    status: json["status"],
    message: json["message"],
    data: List<BannerDatum>.from(json["Data"].map((x) => BannerDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BannerDatum {
  String? id;
  String? title;
  String? url;
  String? image;

  BannerDatum({
    this.id,
    this.title,
    this.url,
    this.image,
  });

  factory BannerDatum.fromJson(Map<String, dynamic> json) => BannerDatum(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "image": image,
  };
}
