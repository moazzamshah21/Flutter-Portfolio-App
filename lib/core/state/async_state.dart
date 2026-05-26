sealed class AsyncState<T> {
  const AsyncState();
}

final class AsyncInitial<T> extends AsyncState<T> {
  const AsyncInitial();
}

final class AsyncLoading<T> extends AsyncState<T> {
  const AsyncLoading();
}

final class AsyncSuccess<T> extends AsyncState<T> {
  const AsyncSuccess(this.data);

  final T data;
}

final class AsyncError<T> extends AsyncState<T> {
  const AsyncError(this.message, {this.cause});

  final String message;
  final Object? cause;
}
