/// Returns the [function] result on succes or throw the [exception] on error
T tryThrow<T>(T Function() function, Exception exception) {
  return () {
    try {
      return function();
    } catch (_) {
      throw exception;
    }
  }();
}
