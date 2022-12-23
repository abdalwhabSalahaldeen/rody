import 'dart:convert';

List<Control> ControlFromJson(String str) =>
    List<Control>.from(json.decode(str).map((x) => Control.fromJson(x)));

String ControlToJson(List<Control> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Control {
  Control({
    required this.id,
    required this.websiteName,
    required this.logo,
    required this.description,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.snapchat,
    required this.location,
    required this.usagePolicy,
    required this.termsOfUse,
    required this.aboutUs,
    required this.email,
    required this.callUs,
  });

  int id;
  String websiteName;
  String logo;
  String description;
  String facebook;
  String twitter;
  String instagram;
  String snapchat;
  String location;
  String usagePolicy;
  String termsOfUse;
  String aboutUs;
  String email;
  String callUs;

  factory Control.fromJson(Map<String, dynamic> json) => Control(
        id: json["id"],
        websiteName: json["website_name"],
        logo: json["logo"],
        description: json["description"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        snapchat: json["snapchat"],
        location: json["location"],
        usagePolicy: json["usage_policy"],
        termsOfUse: json["terms_of_use"],
        aboutUs: json["about_us"],
        email: json["email"],
        callUs: json["call_us"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "website_name": websiteName,
        "logo": logo,
        "description": description,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "snapchat": snapchat,
        "location": location,
        "usage_policy": usagePolicy,
        "terms_of_use": termsOfUse,
        "about_us": aboutUs,
        "email": email,
        "call_us": callUs,
      };
}
