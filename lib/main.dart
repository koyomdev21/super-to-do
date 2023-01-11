import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_to_do/src/app.dart';
import 'package:super_to_do/src/exceptions/async_error_logger.dart';
import 'package:super_to_do/src/exceptions/error_logger.dart';
import 'package:super_to_do/src/resources_manager/local_data/local_data_repository.dart';
import 'package:super_to_do/src/resources_manager/local_data/sembast_cart_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataRepository = await SembastDataRepository.makeDefault();
  final container = ProviderContainer(
    overrides: [
      localDataRepositoryProvider.overrideWithValue(localDataRepository),
    ],
    observers: [AsyncErrorLogger()],
  );
  await dotenv.load(fileName: "assets/.env");
  // FlutterError.demangleStackTrace = (StackTrace stack) {
  //   if (stack is stack_trace.Trace) return stack.vmTrace;
  //   if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
  //   return stack;
  // };
  final errorLogger = container.read(errorLoggerProvider);
  registerErrorHandlers(errorLogger);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      ),
    );
  };
}
