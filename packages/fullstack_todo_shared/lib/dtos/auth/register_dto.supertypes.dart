// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

part of 'register_dto.dart';

// **************************************************************************
// SuperTypesGenerator
// **************************************************************************

/// Generate for [$RegisterDto]
typedef RegisterDto = ({
  String email,
  String name,
  String password,
});

RegisterDto RegisterDtoFromJson(Map<String, dynamic> json) {
  return (
    email: json['email'] as String,
    name: json['name'] as String,
    password: json['password'] as String,
  );
}

extension RegisterDtoJson on RegisterDto {
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
    };
  }
}
