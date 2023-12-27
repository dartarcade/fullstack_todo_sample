import 'package:goose/goose.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@singleton
class TodoMigration002 extends Migration {
  TodoMigration002(this.db)
      : super('add user_id column', description: 'Add a user ID column');

  final Connection db;

  @override
  Future<void> up() async {
    await db.execute('''
      alter table todo add column user_id integer not null references "users" (id);
    ''');
  }

  @override
  Future<void> down() async {
    await db.execute('alter table todo drop column user_id;');
  }
}
