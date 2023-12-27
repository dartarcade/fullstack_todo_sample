import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/modules/auth/dtos/register_dto.dart';
import 'package:fullstack_todo_arcade/repositories/user_repository.dart';
import 'package:fullstack_todo_arcade/shared/dtos/tokens.dart';
import 'package:fullstack_todo_arcade/shared/dtos/user.dart';
import 'package:fullstack_todo_arcade/shared/services/jwt_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  const AuthService(this._jwtService, this._userRepository);

  final JwtService _jwtService;
  final UserRepository _userRepository;

  Future<UserWithTokens> register(RegisterDto dto) async {
    final existingUser = await _userRepository.findBy(email: dto.email);
    if (existingUser != null) {
      throw const ConflictException(message: 'User already exists');
    }
    
    final user = await _userRepository.create(
      (
        name: dto.name,
        email: dto.email,
        password: dto.password,
      ),
    );
    final Tokens tokens = (
      accessToken: _jwtService.generateAccessToken((id: user.id)),
      refreshToken: _jwtService.generateRefreshToken((id: user.id)),
    );

    return UserWithTokensFromJson({...user.toJson(), ...tokens.toJson()});
  }
}
