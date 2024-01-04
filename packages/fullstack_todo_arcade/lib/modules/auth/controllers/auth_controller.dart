import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/modules/auth/services/auth_service.dart';
import 'package:fullstack_todo_arcade/shared/extensions/request_context.dart';
import 'package:fullstack_todo_shared/dtos/auth/login_dto.dart';
import 'package:fullstack_todo_shared/dtos/auth/refresh_dto.dart';
import 'package:fullstack_todo_shared/dtos/auth/register_dto.dart';
import 'package:fullstack_todo_shared/models/tokens.dart';
import 'package:fullstack_todo_shared/models/user.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthController {
  AuthController(this._authService) {
    Route.group(
      '/auth',
      defineRoutes: () {
        Route.post('/register').handle(register);
        Route.post('/login').handle(login);
        Route.post('/refresh').handle(refresh);
      },
    );
  }

  final AuthService _authService;

  Future<Map<String, dynamic>> register(RequestContext context) async {
    final dto = await context.validateWithLuthor(registerDtoValidator);
    return _authService.register(dto).then((value) => value.toJson());
  }

  Future<Map<String, dynamic>> login(RequestContext context) async {
    final dto = await context.validateWithLuthor(loginDtoValidator);
    return _authService.login(dto).then((value) => value.toJson());
  }

  Future<Map<String, dynamic>> refresh(RequestContext context) async {
    final dto = await context.validateWithLuthor(refreshDtoValidator);
    return _authService.refresh(token: dto.refreshToken).toJson();
  }
}
