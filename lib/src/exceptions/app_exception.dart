import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException {
  // Auth
  const factory AppException.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AppException.weakPassword() = WeakPassword;
  const factory AppException.wrongPassword() = WrongPassword;
  const factory AppException.userNotFound() = UserNotFound;
  // Orders
  const factory AppException.parseOrderFailure(String status) =
      ParseOrderFailure;
}

class AppExceptionData {
  AppExceptionData(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => 'AppExceptionData(code: $code, message: $message)';
}

extension AppExceptionDetails on AppException {
  AppExceptionData get details {
    return when(
      // Auth
      emailAlreadyInUse: () => AppExceptionData(
        'email-already-in-use',
        'Email already in use',
      ),
      weakPassword: () => AppExceptionData(
        'weak-password',
        'Password is too weak',
      ),
      wrongPassword: () => AppExceptionData(
        'wrong-password',
        'Wrong password',
      ),
      userNotFound: () => AppExceptionData(
        'user-not-found',
        'User not found',
      ),
      // Orders
      parseOrderFailure: (status) => AppExceptionData(
        'parse-order-failure',
        'Could not parse order status: $status',
      ),
    );
  }
}
