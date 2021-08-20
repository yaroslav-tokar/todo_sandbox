import 'dart:developer';

const String _defaultLogInfoTag = 'debug_info';
const String _defaultLogErrorTag = 'debug_error';

Future<void> logInfo(String message) async =>
    log('$_defaultLogInfoTag\t$message');

Future<void> logError(String message) async =>
    log
      ('$_defaultLogErrorTag\t$message');
