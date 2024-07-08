class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

/*
this class is used because [deadline] and [color]
can be intentionally null, using a regular copyWith
would result in following:

  deadline: deadline,
  color: color,

    - without explicitly passing these fields
      they are being set to null with each update
      

  deadline: deadline ?? this.deadline,
  color: color ?? this.color,

    - passing null wouldn't allow us to
      explicitly set these fields to null,
      which is required in case we want to
      get rid of previously set values
 */