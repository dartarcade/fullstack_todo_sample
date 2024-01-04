import 'package:auto_route/auto_route.dart';
import 'package:fullstack_demo_flutter/core/routes/app_router.gr.dart';
import 'package:fullstack_demo_flutter/state/auth/auth_model.dart';
import 'package:injectable/injectable.dart';
import 'package:watch_it/watch_it.dart';

@singleton
class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final authModel = await di.getAsync<AuthModel>();
    final isLoggedIn = authModel.isLoggedIn;
    if (isLoggedIn) {
      resolver.next();
    } else {
      router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
    }
  }
}
