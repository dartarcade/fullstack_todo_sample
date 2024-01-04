
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_demo_flutter/core/routes/app_router.dart';
import 'package:fullstack_demo_flutter/core/routes/app_router.gr.dart';
import 'package:fullstack_demo_flutter/state/auth/auth_model.dart';
import 'package:watch_it/watch_it.dart';

bool _navigating = false;

@RoutePage()
class SplashPage extends WatchingStatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigating = false;
  }

  @override
  Widget build(BuildContext context) {
    allReady(
      onReady: (context) {
        if (_navigating) return;
        _navigating = true;
        final isLoggedIn = di<AuthModel>().isLoggedIn;
        if (isLoggedIn) {
          router.replace(const HomeRoute());
        } else {
          router.replace(const LoginRoute());
        }
      },
    );

    return const Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
