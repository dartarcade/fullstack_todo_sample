import 'package:auto_route/auto_route.dart';
import 'package:fullstack_demo_flutter/core/routes/app_router.gr.dart';
import 'package:fullstack_demo_flutter/core/routes/guards/auth_gaurd.dart';
import 'package:injectable/injectable.dart';
import 'package:watch_it/watch_it.dart';

@singleton
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        initial: true,
        path: '/',
        page: SplashRoute.page,
      ),
      AutoRoute(
        path: '/auth/login',
        page: LoginRoute.page,
      ),
      // TODO: Add a route for the registration page
      AutoRoute(
        path: '/home',
        page: HomeRoute.page,
        guards: [di<AuthGuard>()],
      ),
    ];
  }
}

AppRouter get router => di();
