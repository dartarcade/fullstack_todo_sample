import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fullstack_demo_flutter/state/auth/auth_state.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AuthModel extends ChangeNotifier {
  AuthModel(this._prefs);

  final SharedPreferences _prefs;

  AuthState state = AuthState.initial();

  @postConstruct
  void init() {
    final authState = _prefs.getString('authState');
    if (authState != null) {
      state = AuthState.fromJson(jsonDecode(authState) as Map<String, dynamic>);
    }
  }

  void saveState() {
    _prefs.setString('authState', jsonEncode(state.toJson()));
  }
  
  bool get isLoggedIn => state.loginState?.isRight ?? false;
}
