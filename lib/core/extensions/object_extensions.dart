// public static TResult Then<TSource, TResult>(this TSource source, Func<TSource, TResult> lambda)
// 	{
// 		return lambda(source);
// 	}

extension ObjectExtensions<Object, TResult> on Object {
  TResult then(TResult Function(Object) lambda) {
    return lambda(this);
  }
}
