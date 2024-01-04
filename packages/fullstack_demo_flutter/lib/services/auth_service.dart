import 'package:dio/dio.dart';
import 'package:fullstack_demo_flutter/services/utils/dio_extension.dart';
import 'package:fullstack_demo_flutter/shared/either.dart';
import 'package:fullstack_demo_flutter/shared/failure.dart';
import 'package:fullstack_todo_shared/dtos/auth/login_dto.dart';
import 'package:fullstack_todo_shared/models/user.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  const AuthService(this.dio);

  final Dio dio;

  Future<Either<Failure, UserWithTokens>> login(LoginDto dto) async {
    final responseOrFailure = await dio.handleErrors(
      dio.post('/auth/login', data: dto.toJson()),
      successMapper: (Map<String, dynamic> data) =>
          UserWithTokensFromJson(data),
    );
    return responseOrFailure.map((r) => r.data!);
  }
}
