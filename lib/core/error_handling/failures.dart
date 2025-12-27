abstract class AppFailure implements Exception {
  final String? message;
  const AppFailure(this.message);
}

class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.message);
}

class ServerFailure extends AppFailure {
  final int? code;
  const ServerFailure(super.message, {this.code});
}

class ConnectionFailure extends AppFailure {
  const ConnectionFailure(super.message);
}

class NoInternetFailure extends AppFailure {
  const NoInternetFailure() : super('No internet connection available.');
}
