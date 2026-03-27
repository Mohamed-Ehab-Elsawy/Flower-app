import 'package:flower_app/core/error_handling/result.dart';

import 'handle_exception.dart';

Stream<Result<T>> handleStreamApi<T>(Stream<T> Function() streamCall) {
  try {
    return streamCall()
        .map((data) => Success<T>(data))
        .handleError(
          (error) => Failure<T>(
            NetworkException.getMessageError(
              error is Exception ? error : Exception(error.toString()),
            ),
          ),
        );
  } on Exception catch (e) {
    return Stream.value(Failure<T>(NetworkException.getMessageError(e)));
  }
}
