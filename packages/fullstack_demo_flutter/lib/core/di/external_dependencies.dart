import 'package:dio/dio.dart';
import 'package:fullstack_demo_flutter/core/env.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ExternalDependencies {
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: Env.baseUrl));
}
