abstract class UseCase<T, P> {
  Future<T> call({P? params});
}

abstract class StreamableUseCase<T, P> {
  Stream<T> call({P? params});
}
