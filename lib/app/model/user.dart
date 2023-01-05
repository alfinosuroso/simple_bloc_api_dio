// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.id,
        this.name,
        this.email,
        this.gender,
        this.status,
    });

    int? id;
    String? name;
    String? email;
    Gender? gender;
    Status? status;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: genderValues.map[json["gender"]],
        status: statusValues.map[json["status"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": genderValues.reverse[gender],
        "status": statusValues.reverse[status],
    };
}

enum Gender { male, female }

final genderValues = EnumValues({
    "female": Gender.female,
    "male": Gender.male
});

enum Status { active, inactive }

final statusValues = EnumValues({
    "active": Status.active,
    "inactive": Status.inactive
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
