import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/core/env.dart';
import 'package:fullstack_todo_arcade/core/init.dart';

Future<void> main() async {
  return runServer(port: Env.port, init: init);
}
