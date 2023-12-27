import 'package:fullstack_todo_arcade/core/init.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> init() async {
  await getIt.reset();
  await getIt.init();
}
