import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/core/init.dart';
import 'package:fullstack_todo_arcade/shared/contexts/is_auth_context.dart';
import 'package:fullstack_todo_arcade/shared/services/jwt_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthHook {
  const AuthHook(this._jwtService);

  final JwtService _jwtService;

  IsAuthContext call(RequestContext context) {
    final token = context.requestHeaders['authorization']?.first;
    if (token == null) {
      throw const UnauthorizedException(message: 'Token not found');
    }
    final payload =
        _jwtService.verifyAccessToken(token.replaceFirst('Bearer ', ''));
    return IsAuthContext(
      context: context,
      payload: payload,
    );
  }
}

AuthHook get authHook => getIt<AuthHook>();
