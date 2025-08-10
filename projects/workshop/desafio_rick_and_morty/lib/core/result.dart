sealed class Result<T> {
  const Result();
  R when<R>({required R Function(T) ok, required R Function(String) err}) =>
      switch (this) {
        Ok(:final value) => ok(value),
        Err(:final message) => err(message),
      };
}

class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

class Err<T> extends Result<T> {
  final String message;
  const Err(this.message);
}
