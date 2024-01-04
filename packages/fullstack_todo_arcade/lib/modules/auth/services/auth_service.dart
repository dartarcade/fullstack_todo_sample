import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/modules/auth/repositories/user_repository.dart';
import 'package:fullstack_todo_arcade/shared/services/hash_service.dart';
import 'package:fullstack_todo_arcade/shared/services/jwt_service.dart';
import 'package:fullstack_todo_shared/dtos/auth/login_dto.dart';
import 'package:fullstack_todo_shared/dtos/auth/register_dto.dart';
import 'package:fullstack_todo_shared/models/tokens.dart';
import 'package:fullstack_todo_shared/models/user.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  const AuthService(this._hashService, this._jwtService, this._userRepository);

  final HashService _hashService;
  final JwtService _jwtService;
  final UserRepository _userRepository;

  Future<UserWithTokens> register(RegisterDto dto) async {
    final existingUser = await _userRepository.findBy(email: dto.email);
    if (existingUser != null) {
      throw const ConflictException(message: 'User already exists');
    }

    final hashedPassword = await _hashService.hash(dto.password);

    final user = await _userRepository.create(
      (
        name: dto.name,
        email: dto.email,
        password: hashedPassword,
      ),
    );
    final Tokens tokens = (
      accessToken: _jwtService.generateAccessToken((id: user.id)),
      refreshToken: _jwtService.generateRefreshToken((id: user.id)),
    );

    return UserWithTokensFromJson({...user.toJson(), ...tokens.toJson()});
  }

  Future<UserWithTokens> login(LoginDto dto) async {
    final user = await _userRepository.findBy(email: dto.email);
    if (user == null) {
      throw const NotFoundException(message: 'User not found');
    }

    final Tokens tokens = (
      accessToken: _jwtService.generateAccessToken((id: user.id)),
      refreshToken: _jwtService.generateRefreshToken((id: user.id)),
    );

    return UserWithTokensFromJson({...user.toJson(), ...tokens.toJson()});
  }

  AccessToken refresh({required String token}) {
    final payload = _jwtService.verifyRefreshToken(token);
    final accessToken = _jwtService.generateAccessToken((id: payload.id));
    return AccessTokenFromJson({'access_token': accessToken});
  }
}
