import 'package:fullstack_demo_flutter/shared/either.dart';
import 'package:fullstack_demo_flutter/state/auth/auth_state.dart';
import 'package:fullstack_todo_shared/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

class UserWithTokensStateConverter
    extends JsonConverter<UserWithTokensState?, Map<String, dynamic>?> {
  const UserWithTokensStateConverter();

  @override
  UserWithTokensState? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    final type = json['type'] as String;
    return switch (type) {
      'left' => null,
      'right' => Right(
          UserWithTokensFromJson(json['loginState'] as Map<String, dynamic>),
        ),
      _ => throw ArgumentError.value(type, 'type', 'Invalid type'),
    };
  }

  @override
  Map<String, dynamic>? toJson(UserWithTokensState? state) {
    if (state == null) return null;
    return {
      'type': switch (state) {
        Left() => 'left',
        Right() => 'right',
      },
      'loginState': state.toJson(
        toJsonL: (_) => 'failure',
        toJsonR: (value) => value.toJson(),
      ),
    };
  }
}
