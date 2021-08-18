const String _defaultLogInfoTag = 'debug_info';
const String _defaultLogErrorTag = 'debug_error';

Future<void> logInfo(String message) async =>
    print('$_defaultLogInfoTag\t$message');

Future<void> logError(String message) async =>
    print('$_defaultLogErrorTag\t$message');
