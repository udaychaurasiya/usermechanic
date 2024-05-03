// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  int? status;
  String? message;
  Data? data;

  ContactUsModel({
    this.status,
    this.message,
    this.data,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
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
  String? title;
  String? feviconIcon;
  String? logo;
  String? website;
  String? websiteLink;
  String? email;
  String? mobile;
  String? address;
  dynamic shortDescription;
  dynamic instaLink;
  dynamic twitterLink;
  dynamic fbLink;

  Data({
    this.title,
    this.feviconIcon,
    this.logo,
    this.website,
    this.websiteLink,
    this.email,
    this.mobile,
    this.address,
    this.shortDescription,
    this.instaLink,
    this.twitterLink,
    this.fbLink,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    feviconIcon: json["fevicon_icon"]??"",
    logo: json["logo"],
    website: json["website"],
    websiteLink: json["website_link"]??"",
    email: json["email"]??"",
    mobile: json["mobile"]??"",
    address: json["address"]??"",
    shortDescription: json["short_description"]??"",
    instaLink: json["insta_link"]??"",
    twitterLink: json["twitter_link"],
    fbLink: json["fb_link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "fevicon_icon": feviconIcon,
    "logo": logo,
    "website": website,
    "website_link": websiteLink,
    "email": email,
    "mobile": mobile,
    "address": address,
    "short_description": shortDescription,
    "insta_link": instaLink,
    "twitter_link": twitterLink,
    "fb_link": fbLink,
  };
}
