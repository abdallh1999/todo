import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');

      case DioExceptionType.connectionError:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response.toString());

      // return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
class ServerException extends Equatable implements Exception {
  final String message;
  const ServerException({required this.message});
  @override
  List<Object?> get props => [message];
}

class CacheException implements Exception {}

class FetchDataException extends ServerException {
  const FetchDataException() : super(message: "error during communication");
}

class BadRequestException extends ServerException {
  const BadRequestException() : super(message: "bad request");
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException() : super(message: "Unauthorized");
}

class NotFoundException extends ServerException {
  const NotFoundException() : super(message: "Not Found");
}

class ConflictException extends ServerException {
  const ConflictException() : super(message: "Conflict Occurred");
}

class InternalServerException extends ServerException {
  const InternalServerException() : super(message: "Internal Server error");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException()
      : super(message: "No Internet Connection");
}
