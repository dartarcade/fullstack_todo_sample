import 'package:goose/goose.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@singleton
class TodoMigration001 extends Migration {
  TodoMigration001(this.db)
      : super('create_todo', description: 'Create todo table');

  final Connection db;

  @override
  Future<void> up() async {
    await db.execute('''
      create table if not exists todo (
        id serial primary key,
        title varchar(255) not null,
        description text not null,
        is_done boolean not null default false,
        created_at timestamp not null default now(),
        updated_at timestamp not null default now()
      );
    ''');
  }

  @override
  Future<void> down() async {
    await db.execute('drop table if exists todo;');
  }
}
