import 'package:fullstack_todo_arcade/core/env.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@module
abstract class ExternalDependencies {
  @preResolve
  @singleton
  Future<Connection> get db async {
    final uri = Uri.parse(Env.dbUrl);
    return await Connection.open(
      Endpoint(
        host: uri.host,
        database: uri.pathSegments.first,
        username: uri.userInfo.split(':').first,
        password: uri.userInfo.split(':').last,
      ),
      settings: ConnectionSettings(
        sslMode:
            uri.queryParameters['sslmode'] == 'true' ? SslMode.require : null,
      ),
    );
  }
}
