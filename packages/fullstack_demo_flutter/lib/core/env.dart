import 'dart:io';

import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';

@Envied()
class Env {
  const Env._();

  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = !kIsWeb && Platform.isAndroid
      ? _Env.baseUrl.replaceFirst('localhost', '10.0.2.2')
      : _Env.baseUrl;
}
