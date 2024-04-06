// To parse this JSON data, do
//
//     final brandTypeModel = brandTypeModelFromJson(jsonString);

import 'dart:convert';

BrandTypeModel brandTypeModelFromJson(String str) => BrandTypeModel.fromJson(json.decode(str));

String brandTypeModelToJson(BrandTypeModel data) => json.encode(data.toJson());

class BrandTypeModel {
  int? status;
  String? message;
  List<Brand> data;

  BrandTypeModel({
    this.status,
    this.message,
    required this.data,
  });

  factory BrandTypeModel.fromJson(Map<String, dynamic> json) => BrandTypeModel(
    status: json["status"],
    message: json["message"],
    data: List<Brand>.from(json["Data"].map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Brand {
  String? id;
  String? title;
  String? description;
  String? image;
  String? status;
  DateTime? addDate;

  Brand({
    this.id,
    this.title,
    this.description,
    this.image,
    this.status,
    this.addDate,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "status": status,
    "add_date": addDate!.toIso8601String(),
  };
}
