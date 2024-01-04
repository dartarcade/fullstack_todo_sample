import 'package:fullstack_todo_arcade/modules/todo/repositories/todo_repository.dart';
import 'package:fullstack_todo_shared/dtos/todos/todo.dart';
import 'package:injectable/injectable.dart';

@singleton
class TodoService {
  const TodoService(this._todoRepository);

  final TodoRepository _todoRepository;

  Future<List<Todo>> getTodos(int id) {
    return _todoRepository.getTodos(id);
  }

  Future<Todo> createTodo({required int userId, required CreateTodo dto}) {
    return _todoRepository.createTodo(
      userId: userId,
      dto: dto,
    );
  }

  Future<Todo> toggleDone({
    required int id,
    required UpdateTodo dto,
    required int userId,
  }) {
    return _todoRepository.updateTodo(id: id, dto: dto, userId: userId);
  }

  Future<Todo> deleteTodo({required int id, required int userId}) {
    return _todoRepository.deleteTodo(id: id, userId: userId);
  }
}
