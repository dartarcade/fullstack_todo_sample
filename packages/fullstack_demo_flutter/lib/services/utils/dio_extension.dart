import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fullstack_demo_flutter/shared/either.dart';
import 'package:fullstack_demo_flutter/shared/failure.dart';

typedef DioRequest<T> = Future<Response<T>>;

extension HandleErrorsX on Dio {
  Future<Either<Failure, Response<T>>> handleErrors<T, TData>(
    DioRequest request, {
    T Function(TData data)? successMapper,
  }) async {
    try {
      final response = await request;
      if (successMapper != null) {
        response.data = successMapper(response.data as TData);
      }
      return Right(_castResponse(response));
    } on DioException catch (e, s) {
      final DioException(
        type: type,
        response: response,
        error: error,
      ) = e;
      debugPrint('DioException: $type\n$s');
      return switch (type) {
        DioExceptionType.badCertificate =>
          Left(Failure.unknownError(Error.safeToString('Bad certificate'))),
        DioExceptionType.badResponse => _handleBadResponse(response!),
        DioExceptionType.cancel => const Left(Failure.cancelled()),
        DioExceptionType.unknown => Left(Failure.unknownError(error, s)),
        _ => const Left(Failure.networkError()),
      };
    } catch (e, s) {
      return Left(Failure.unknownError(e, s));
    }
  }

  Response<T> _castResponse<T>(Response response) {
    return Response(
      data: response.data as T,
      headers: response.headers,
      requestOptions: response.requestOptions,
      isRedirect: response.isRedirect,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      redirects: response.redirects,
      extra: response.extra,
    );
  }

  Left<Failure, Response<T>> _handleBadResponse<T>(Response response) {
    final Response(data: data) = response;
    if (data is! Map) {
      return const Left(Failure.unknownError());
    }
    final {'message': message, 'errors': errors} = data;
    if (message is! String || errors is! Map) {
      return const Left(Failure.unknownError());
    }
    return Left(
      Failure.badRequest(
        message: message,
        errors: errors.cast<String, dynamic>(),
      ),
    );
  }
}
