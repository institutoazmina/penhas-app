import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

typedef OnBeforeRun = FutureOr<void> Function();

/// Singleton class responsible for bootstrapping the application.
class Bootstrap {
  @visibleForTesting
  Bootstrap([Logger? logger]) : _logger = logger ?? Logger('Bootstrap') {
    instance = this;
  }

  final Logger _logger;

  static Bootstrap? _instance;

  static Bootstrap get instance => _instance ??= Bootstrap();

  static set instance(Bootstrap value) => _instance = value;

  /// Starts the application with the provided [runner].
  ///
  /// It initializes, configures, and runs the application using the given [runner].
  Future<void> withRunner(
    Runner runner, {
    OnBeforeRun? onBeforeRun,
  }) async {
    try {
      await runner.initialize();
      await runner.configure();
      if (onBeforeRun != null) await onBeforeRun();

      runner.run();
    } catch (error, stack) {
      _logger.shout('Uncaught error', error, stack);
    }
  }
}

/// Abstract class representing the running and management of the application.
abstract class Runner {
  /// Initializes the application.
  ///
  /// This method is called before [configure] and [run].
  FutureOr<void> initialize();

  /// Configures the application.
  ///
  /// This method is called after [initialize] and before [run].
  FutureOr<void> configure();

  /// Runs the application.
  ///
  /// This method is called after [initialize] and [configure].
  void run();
}
