import 'package:dargon2/dargon2.dart';
import 'package:injectable/injectable.dart';

@singleton
class HashService {
  const HashService();

  Future<String> hash(String password) {
    return argon2
        .hashPasswordString(password, salt: Salt.newSalt())
        .then((value) => value.encodedString);
  }

  Future<bool> verify(String password, String hash) {
    return argon2.verifyHashString(password, hash);
  }
}
