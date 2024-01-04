// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

part of 'login_dto.dart';

// **************************************************************************
// SuperTypesGenerator
// **************************************************************************

/// Generate for [$LoginDto]
typedef LoginDto = ({
  String email,
  String password,
});

LoginDto LoginDtoFromJson(Map<String, dynamic> json) {
  return (
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

extension LoginDtoJson on LoginDto {
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
