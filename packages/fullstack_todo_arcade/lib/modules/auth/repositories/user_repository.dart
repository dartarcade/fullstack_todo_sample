import 'package:fullstack_todo_shared/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@singleton
class UserRepository {
  static const _tableName = 'users';

  UserRepository(this.db);

  final Connection db;

  Future<User?> findBy({int? id, String? email}) async {
    assert(id != null || email != null);
    const sql = 'select * from $_tableName where';

    late String finalSql;
    late Map<String, dynamic> parameters;
    if (id != null) {
      finalSql = '$sql id = @id';
      parameters = {'id': TypedValue(Type.integer, id)};
    } else {
      finalSql = '$sql email = @email';
      parameters = {'email': TypedValue(Type.text, email)};
    }

    final result =
        await db.execute(Sql.named(finalSql), parameters: parameters);
    if (result.isEmpty) return null;
    return UserFromJson(result.first.toColumnMap());
  }

  Future<UserWithoutPassword> create(CreateUser user) async {
    const sql = '''
      insert into $_tableName (name, email, password)
      values (@name, @email, @password)
      returning *
    ''';

    final result = await db.execute(Sql.named(sql), parameters: user.toJson());
    return UserWithoutPasswordFromJson(result.first.toColumnMap());
  }
}
