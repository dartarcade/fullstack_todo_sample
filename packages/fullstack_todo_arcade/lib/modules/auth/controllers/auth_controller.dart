import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/modules/auth/dtos/register_dto.dart';
import 'package:fullstack_todo_arcade/modules/auth/services/auth_service.dart';
import 'package:fullstack_todo_arcade/shared/dtos/user.dart';
import 'package:fullstack_todo_arcade/shared/extensions/request_context.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthController {
  AuthController(this._authService) {
    Route.group(
      '/auth',
      defineRoutes: () {
        Route.post('/register').handle(register);
      },
    );
  }

  final AuthService _authService;

  Future<Map<String, dynamic>> register(RequestContext context) async {
    final dto = await context.validateWithLuthor(registerDtoValidator);
    return _authService.register(dto).then((value) => value.toJson());
  }
}
