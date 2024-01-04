import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@Freezed(map: FreezedMapOptions.none, when: FreezedWhenOptions.none)
sealed class Failure with _$Failure {
  const factory Failure.badRequest({
    required String message,
    required Map<String, dynamic> errors,
  }) = BadRequest;

  const factory Failure.cancelled() = Cancelled;

  const factory Failure.networkError() = NetworkError;

  const factory Failure.unknownError([
    Object? originalError,
    StackTrace? stackTrace,
  ]) = UnknownError;
}
