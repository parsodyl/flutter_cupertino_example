enum _ResultType { success, error }

abstract class Result<T> {
  _ResultType _type;
  T _data;
  Object _error;

  Result._success(this._data) : _type = _ResultType.success;

  Result._error(this._error) : _type = _ResultType.error;

  factory Result.success(T data) => ResultSuccess._(data);

  factory Result.error(Object error) => ResultError._(error);

  bool get isSuccess => _type == _ResultType.success;
  bool get isError => _type == _ResultType.error;

  Object get cause {
    assert(this.isError);
    return (this as ResultError).cause;
  }

  T get data {
    assert(this.isSuccess);
    return (this as ResultSuccess<T>).data;
  }
}

class ResultSuccess<T> extends Result<T> {
  ResultSuccess._(T data) : super._success(data);

  T get data => super._data;
}

class ResultError<T> extends Result<T> {
  ResultError._(Object error) : super._error(error);

  Object get cause => super._error;
}
