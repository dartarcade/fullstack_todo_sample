import 'package:fullstack_todo_arcade/core/external_dependencies.dart';
import 'package:fullstack_todo_arcade/shared/dtos/user.dart';
import 'package:goose/goose.dart';

/// Migration to create a [User] table
class UserMigration001 extends Migration {
  const UserMigration001() : super('user001', description: 'Create user table');

  @override
  Future<void> up() async {
    await db.execute('''
    create table if not exists users (
      id serial primary key,
      name text not null,
      email text not null unique,
      password text not null,
      created_at timestamp not null default now(),
      updated_at timestamp not null default now()
    );
    ''');
  }

  @override
  Future<void> down() {
    return db.execute('drop table if exists users;');
  }
}
