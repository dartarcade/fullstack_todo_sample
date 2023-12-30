import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/modules/todo/dtos/todo.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@singleton
class TodoRepository {
  const TodoRepository(this._db);

  final Connection _db;

  Future<List<Todo>> getTodos(int userId) async {
    final sql = Sql.named('select * from todo where user_id = @userId;');
    final result = await _db.execute(
      sql,
      parameters: {'userId': TypedValue(Type.integer, userId)},
    );
    return result.map((row) => TodoFromJson(row.toColumnMap())).toList();
  }

  Future<Todo> createTodo({
    required int userId,
    required CreateTodo dto,
  }) async {
    final sql = Sql.named('''
      insert into todo (title, description, user_id) values (@title, @description, @userId)
      returning *;
    ''');
    final result = await _db.execute(
      sql,
      parameters: {
        'title': TypedValue(Type.text, dto.title),
        'description': TypedValue(Type.text, dto.description),
        'userId': TypedValue(Type.integer, userId),
      },
    );
    return TodoFromJson(result.first.toColumnMap());
  }

  Future<Todo> toggleDone({required int id, required int userId}) async {
    final existsResult = await _db.execute(
      Sql.named('select * from todo where id = @id and user_id = @userId;'),
      parameters: {
        'id': TypedValue(Type.integer, id),
        'userId': TypedValue(Type.integer, userId),
      },
    );
    
    if (existsResult.isEmpty) {
      throw NotFoundException(message: 'Todo with id $id does not exist');
    }

    final sql = Sql.named('''
      update todo set is_done = not is_done, updated_at = now() where id = @id
      returning *;
    ''');
    final result = await _db.execute(
      sql,
      parameters: {
        'id': TypedValue(Type.integer, id),
      },
    );
    return TodoFromJson(result.first.toColumnMap());
  }
}
