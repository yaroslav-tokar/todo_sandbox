class EntityNotFoundException implements Exception {
  final String? message;

  EntityNotFoundException({this.message = 'Entity not found'});
}
