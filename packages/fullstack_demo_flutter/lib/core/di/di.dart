import 'package:fullstack_demo_flutter/core/di/di.config.dart';
import 'package:injectable/injectable.dart';
import 'package:watch_it/watch_it.dart';

@injectableInit
void configureDi() {
  di.init();
}
