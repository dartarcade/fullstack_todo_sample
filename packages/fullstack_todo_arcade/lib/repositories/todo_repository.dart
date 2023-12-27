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
}
