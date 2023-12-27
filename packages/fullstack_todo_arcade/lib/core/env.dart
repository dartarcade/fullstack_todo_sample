import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
class Env {
  @EnviedField(varName: 'PORT')
  static const int port = _Env.port;

  @EnviedField(varName: 'DB_URL')
  static const String dbUrl = _Env.dbUrl;

  @EnviedField(varName: 'JWT_ACCESS_SECRET')
  static const String jwtAccessSecret = _Env.jwtAccessSecret;

  @EnviedField(varName: 'JWT_REFRESH_SECRET')
  static const String jwtRefreshSecret = _Env.jwtRefreshSecret;
}
