// To parse this JSON data, do
//
//     final categryModel = categryModelFromJson(jsonString);

import 'dart:convert';

CategryModel categryModelFromJson(String str) => CategryModel.fromJson(json.decode(str));

String categryModelToJson(CategryModel data) => json.encode(data.toJson());

class CategryModel {
  int? status;
  String? message;
  List<Datum2> data;

  CategryModel({
    this.status,
    this.message,
    required this.data,
  });

  factory CategryModel.fromJson(Map<String, dynamic> json) => CategryModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum2>.from(json["Data"].map((x) => Datum2.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum2 {
  String? id;
  String? title;
  String? amount;
  String? description;
  String? image;
  String? status;
  DateTime? addDate;

  Datum2({
    this.id,
    this.title,
    this.amount,
    this.description,
    this.image,
    this.status,
    this.addDate,
  });

  factory Datum2.fromJson(Map<String, dynamic> json) => Datum2(
    id: json["id"],
    title: json["title"],
    amount: json["amount"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "amount": amount,
    "description": description,
    "image": image,
    "status": status,
    "add_date": addDate!.toIso8601String(),
  };
}
