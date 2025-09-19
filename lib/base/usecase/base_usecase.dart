abstract class BaseUseCase<R, P> {
  Future<R> call(P param);
}

abstract class BaseUseCaseNoResult<P> {
  Future<void> call(P param);
}

abstract class BaseUseCaseListResult<R, P> {
  Future<List<R>> call(P param);
}

abstract class BaseNormalUseCase {
  Future<void> call();
}

abstract class BaseResultUseCase<R> {
  Future<R> call();
}
