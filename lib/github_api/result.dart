enum ResultType { success, failure }

class ErrorData {
  int code;
  String msg;

  ErrorData(this.code, this.msg);
}

class Result<T> {
  T data;
  ResultType type = ResultType.failure;

  Result(this.data, this.type);

  T? handleResult() {
    switch (type) {
      case ResultType.success:
        return data;
      case ResultType.failure:
        print("error: ${(data as ErrorData).msg}");
        break;
    }
  }
}
