// To parse this JSON data, do
//
//     final employeeDetailsResponse = employeeDetailsResponseFromJson(jsonString);

import 'dart:convert';

EmployeeDetailsResponse employeeDetailsResponseFromJson(String str) => EmployeeDetailsResponse.fromJson(json.decode(str));

String employeeDetailsResponseToJson(EmployeeDetailsResponse data) => json.encode(data.toJson());

class EmployeeDetailsResponse {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  EmployeeDetailsResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory EmployeeDetailsResponse.fromJson(Map<String, dynamic> json) => EmployeeDetailsResponse(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}
