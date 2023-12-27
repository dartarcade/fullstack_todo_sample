import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/modules/todo/dtos/todo.dart';
import 'package:fullstack_todo_arcade/modules/todo/services/todo_service.dart';
import 'package:fullstack_todo_arcade/shared/contexts/is_auth_context.dart';
import 'package:fullstack_todo_arcade/shared/extensions/request_context.dart';
import 'package:fullstack_todo_arcade/shared/hooks/auth_hook.dart';
import 'package:injectable/injectable.dart';

@singleton
class TodoController {
  TodoController(this._todoService) {
    Route.group(
      '/todos',
      before: [authHook.call],
      defineRoutes: () {
        Route.get('/').handle((context) => getTodos(context as IsAuthContext));
        Route.post('/')
            .handle((context) => createTodo(context as IsAuthContext));
      },
    );
  }

  final TodoService _todoService;

  Future<List<Map<String, dynamic>>> getTodos(
    covariant IsAuthContext context,
  ) async {
    return _todoService
        .getTodos(context.payload.id)
        .then((todos) => todos.map((todo) => todo.toJson()).toList());
  }

  Future<Map<String, dynamic>> createTodo(
    covariant IsAuthContext context,
  ) async {
    final dto = await context.validateWithLuthor(createTodoValidator);
    return _todoService
        .createTodo(
          userId: context.payload.id,
          dto: dto,
        )
        .then((todo) => todo.toJson());
  }
}
