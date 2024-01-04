import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_shared/dtos/todos/todo.dart';
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

  Future<Todo> updateTodo({
    required int id,
    required UpdateTodo dto,
    required int userId,
  }) async {
    const sql = '''
      update todo set 
    ''';
    final parameters = <String, TypedValue>{
      'id': TypedValue(Type.integer, id),
      'userId': TypedValue(Type.integer, userId),
    };
    String finalSql = sql;

    if (dto.title != null) {
      finalSql += 'title = @title, ';
      parameters['title'] = TypedValue(Type.text, dto.title);
    }

    if (dto.description != null) {
      finalSql += 'description = @description, ';
      parameters['description'] = TypedValue(Type.text, dto.description);
    }

    if (dto.isDone != null) {
      finalSql += 'is_done = @isDone, ';
      parameters['isDone'] = TypedValue(Type.boolean, dto.isDone);
    }

    if (finalSql.endsWith(', ')) {
      finalSql = finalSql.substring(0, finalSql.length - 2);
    }

    finalSql += ' where id = @id and user_id = @userId returning *;';

    final existsResult = await _db.execute(
      Sql.named(finalSql),
      parameters: parameters,
    );

    if (existsResult.isEmpty) {
      throw NotFoundException(message: 'Todo with id $id does not exist');
    }

    final result = await _db.execute(
      Sql.named(finalSql),
      parameters: parameters,
    );
    
    return TodoFromJson(result.first.toColumnMap());
  }

  Future<Todo> deleteTodo({required int id, required int userId}) {
    final sql = Sql.named('''
      delete from todo where id = @id and user_id = @userId
      returning *;
    ''');
    return _db.execute(
      sql,
      parameters: {
        'id': TypedValue(Type.integer, id),
        'userId': TypedValue(Type.integer, userId),
      },
    ).then((result) {
      if (result.isEmpty) {
        throw NotFoundException(message: 'Todo with id $id does not exist');
      }
      return TodoFromJson(result.first.toColumnMap());
    });
  }
}
