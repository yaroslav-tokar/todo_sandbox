class Logger {
  static final _defaultLogInfoTag = 'debug_info';
  static final _defaultLogErrorTag = 'debug_error';

  static i(String message) => print('$_defaultLogInfoTag\t$message');

  static e(String message) => print('$_defaultLogErrorTag\t$message');
}
