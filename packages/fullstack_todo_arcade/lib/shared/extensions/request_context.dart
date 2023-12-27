import 'package:arcade/arcade.dart';
import 'package:luthor/luthor.dart';

extension RequestContextX on RequestContext {
  Future<T> validateWithLuthor<T>(
    SchemaValidationResult<T> Function(Map<String, dynamic>) validator,
  ) async {
    final json = switch (await jsonMap()) {
      BodyParseSuccess(value: final value) => value,
      BodyParseFailure(error: final error) => throw const BadRequestException(
          message: "Invalid JSON",
        ),
    };
    return switch (validator(json)) {
      SchemaValidationSuccess(data: final data) => data,
      SchemaValidationError(errors: final errors) => throw BadRequestException(
          message: "Invalid request",
          errors: errors,
        ),
    };
  }
}
