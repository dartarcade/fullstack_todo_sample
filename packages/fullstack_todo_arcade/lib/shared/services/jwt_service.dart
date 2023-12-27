import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:fullstack_todo_arcade/core/env.dart';
import 'package:fullstack_todo_arcade/shared/dtos/jwt_payload.dart';
import 'package:injectable/injectable.dart';

@singleton
class JwtService {
  const JwtService();

  String generateAccessToken(JwtPayload payload) {
    final token = JWT(payload.toJson());
    return token.sign(SecretKey(Env.jwtAccessSecret), expiresIn: const Duration(minutes: 15));
  }

  String generateRefreshToken(JwtPayload payload) {
    final token = JWT(payload.toJson());
    return token.sign(SecretKey(Env.jwtRefreshSecret), expiresIn: const Duration(days: 7));
  }

  JwtPayload verifyAccessToken(String tokenString) {
    final token = JWT.verify(tokenString, SecretKey(Env.jwtAccessSecret));
    return JwtPayloadFromJson((token.payload as Map).cast());
  }

  JwtPayload verifyRefreshToken(String tokenString) {
    final token = JWT.verify(tokenString, SecretKey(Env.jwtRefreshSecret));
    return JwtPayloadFromJson((token.payload as Map).cast());
  }
}
