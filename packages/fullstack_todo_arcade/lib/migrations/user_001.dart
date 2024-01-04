import 'package:goose/goose.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

/// Migration to create a [User] table
@singleton
class UserMigration001 extends Migration {
  const UserMigration001(this.db) : super('user001', description: 'Create user table');
  
  final Connection db;

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
