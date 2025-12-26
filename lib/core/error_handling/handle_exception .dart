import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/text_strings.dart';


class NetworkException {
  static String getMessageError(Exception exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
          return IAppText.connectionTimeout;
        case DioExceptionType.sendTimeout:
          return IAppText.sendTimeout;
        case DioExceptionType.receiveTimeout:
          return IAppText.receiveTimeout;
        case DioExceptionType.badCertificate:
          return IAppText.badCertificate;
        case DioExceptionType.badResponse:
          return _handleMessageResponse(exception);
        case DioExceptionType.cancel:
          return IAppText.cancel;
        case DioExceptionType.connectionError:
          return IAppText.connectionError;
        case DioExceptionType.unknown:
          return IAppText.unknown;
      }
    } else {
      return exception.toString();
    }
  }

  static String _handleMessageResponse(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      switch (e.response!.statusCode) {
        case 400:
          return IAppText.error400;
        case 401:
          return "${IAppText.error401 + data['error'].toString()} ";
        case 403:
          return IAppText.error403;
        case 404:
          return IAppText.error404;
        case 408:
          return IAppText.error408;
        case 429:
          return IAppText.error429;
        case 500:
          return IAppText.error500;
        case 502:
          return IAppText.error502;
        case 503:
          return IAppText.error503;
        case 504:
          return IAppText.error504;
        default:
          if (data is Map && data['error'] != null) {
            return data['error'].toString();
          }
          return 'Server error (${statusCode ?? 'unknown'}). Please try again.';
      }
    }
    return IAppText.defaultError;
  }
}


