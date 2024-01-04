// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

part of 'refresh_dto.dart';

// **************************************************************************
// SuperTypesGenerator
// **************************************************************************

/// Generate for [$RefreshDto]
typedef RefreshDto = ({
  String refreshToken,
});

RefreshDto RefreshDtoFromJson(Map<String, dynamic> json) {
  return (refreshToken: json['refresh_token'] as String,);
}

extension RefreshDtoJson on RefreshDto {
  Map<String, dynamic> toJson() {
    return {
      'refresh_token': refreshToken,
    };
  }
}
