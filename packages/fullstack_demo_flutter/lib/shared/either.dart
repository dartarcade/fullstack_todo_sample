import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

@Freezed(map: FreezedMapOptions.none, when: FreezedWhenOptions.none)
sealed class Either<L, R> with _$Either<L, R> {
  const factory Either.left(L value) = Left;

  const factory Either.right(R value) = Right;

  const Either._();

  T fold<T>(T Function(L l) ifLeft, T Function(R r) ifRight) {
    return switch (this) {
      Left(value: final l) => ifLeft(l),
      Right(value: final r) => ifRight(r),
    };
  }

  bool get isLeft {
    return switch (this) {
      Left() => true,
      Right() => false,
    };
  }

  bool get isRight => !isLeft;

  R rightOrThrow() {
    return switch (this) {
      Left() => throw StateError('Cannot get the right value on a Left.'),
      Right(value: final r) => r,
    };
  }

  Either<L, R2> map<R2>(R2 Function(R r) mapper) {
    return fold((l) => Left(l), (r) => Right(mapper(r)));
  }

  factory Either.fromJson(
    Map<String, dynamic> json, {
    required L Function(Object) fromJsonL,
    required R Function(Object) fromJsonR,
  }) {
    return json.containsKey('left')
        ? Either.left(fromJsonL(json['left'] as Object))
        : Either.right(fromJsonR(json['right'] as Object));
  }

  Map<String, dynamic> toJson({
    required Object Function(L) toJsonL,
    required Object Function(R) toJsonR,
  }) {
    return fold(
      (l) => {'left': toJsonL(l)},
      (r) => {'right': toJsonR(r)},
    );
  }
}
