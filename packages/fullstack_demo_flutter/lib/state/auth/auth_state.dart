import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fullstack_demo_flutter/core/json_converters/user_with_tokens_converter.dart';
import 'package:fullstack_demo_flutter/shared/either.dart';
import 'package:fullstack_demo_flutter/shared/failure.dart';
import 'package:fullstack_todo_shared/models/user.dart';

part 'auth_state.freezed.dart';

part 'auth_state.g.dart';

typedef UserWithTokensState = Either<Failure, UserWithTokens>;

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @UserWithTokensStateConverter() UserWithTokensState? loginState,
    @UserWithTokensStateConverter() UserWithTokensState? registerState,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  factory AuthState.initial() {
    return const AuthState();
  }
}
