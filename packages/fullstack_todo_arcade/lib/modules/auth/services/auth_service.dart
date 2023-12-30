import 'package:arcade/arcade.dart';
import 'package:fullstack_todo_arcade/modules/auth/dtos/login_dto.dart';
import 'package:fullstack_todo_arcade/modules/auth/dtos/register_dto.dart';
import 'package:fullstack_todo_arcade/modules/auth/repositories/user_repository.dart';
import 'package:fullstack_todo_arcade/shared/dtos/tokens.dart';
import 'package:fullstack_todo_arcade/shared/dtos/user.dart';
import 'package:fullstack_todo_arcade/shared/services/hash_service.dart';
import 'package:fullstack_todo_arcade/shared/services/jwt_service.dart';
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
}
