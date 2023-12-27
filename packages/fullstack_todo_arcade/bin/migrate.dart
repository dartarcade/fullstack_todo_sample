// ignore_for_file: avoid_print

import 'package:fullstack_todo_arcade/core/init.dart';
import 'package:fullstack_todo_arcade/migrations/user_001.dart';
import 'package:goose/goose.dart';
import 'package:postgres/postgres.dart';

Future<void> main() async {
  await init();
  final db = getIt<Connection>();
  print('Running migrations...');
  await db.execute('''
  create table if not exists migrations (
    id int primary key,
    created_at timestamp not null default now()
  );
  ''');

  final goose = Goose(
    migrations: const [
      UserMigration001(),
    ],
    store: (index) {
      return db.execute(
        'insert into migrations (id) values ($index);',
      );
    },
    retrieve: () async {
      final result = await db.execute(
        'select id from migrations order by created_at desc limit 1;',
      );
      return result.firstOrNull?.toColumnMap()['id'] as int?;
    },
  );

  await goose.up();
  await db.close();
}
