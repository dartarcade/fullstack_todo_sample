import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/modules/todo/dtos/todo.dart';
import 'package:fullstack_todo_arcade/modules/todo/services/todo_service.dart';
import 'package:fullstack_todo_arcade/shared/contexts/is_auth_context.dart';
import 'package:fullstack_todo_arcade/shared/extensions/request_context.dart';
import 'package:fullstack_todo_arcade/shared/hooks/auth_hook.dart';
import 'package:injectable/injectable.dart';
import 'package:luthor/luthor.dart';

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
        Route.patch('/:id')
            .handle((context) => toggleDone(context as IsAuthContext));
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

  Future<Map<String, dynamic>> toggleDone(
    covariant IsAuthContext context,
  ) async {
    final idResult = l.int()
        .required()
        .validateValue(int.tryParse(context.pathParameters['id'] ?? ''));
    return switch (idResult) {
      SingleValidationSuccess(data: final data) => _todoService
          .toggleDone(id: data!, userId: context.payload.id)
          .then((todo) => todo.toJson()),
      SingleValidationError(errors: final errors) => throw BadRequestException(
          message: 'Invalid id',
          errors: {'id': errors},
        ),
    };
  }
}
