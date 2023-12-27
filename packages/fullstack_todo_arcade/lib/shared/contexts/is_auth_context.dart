import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/shared/dtos/jwt_payload.dart';

class IsAuthContext extends RequestContext {
  factory IsAuthContext({
    required RequestContext context,
    required JwtPayload payload,
  }) {
    return IsAuthContext._(
      payload: payload,
      route: context.route,
      request: context.rawRequest,
    );
  }

  IsAuthContext._({
    required this.payload,
    required super.route,
    required super.request,
  });

  final JwtPayload payload;
}
