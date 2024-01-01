import 'package:fullstack_todo_arcade/modules/todo/dtos/todo.dart';
import 'package:fullstack_todo_arcade/modules/todo/repositories/todo_repository.dart';
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

  Future<Todo> toggleDone({required int id, required int userId}) {
    return _todoRepository.toggleDone(id: id, userId: userId);
  }

  Future<Todo> deleteTodo({required int id, required int userId}) {
    return _todoRepository.deleteTodo(id: id, userId: userId);
  }
}
