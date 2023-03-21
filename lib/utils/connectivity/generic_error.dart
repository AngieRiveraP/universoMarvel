class GenericError extends Error {
  final String errorCode;
  final String errorMsg;
  final String severity;

  GenericError({
    this.errorCode = '',
    this.errorMsg = '',
    this.severity = '',
  });

  @override
  String toString() {
    String message = '';
    message += 'Code: $errorCode ';
    // ignore: unnecessary_null_comparison
    if (errorMsg != null) {
      message += 'Title: $errorMsg ';
    }
    // ignore: unnecessary_null_comparison
    if (severity != null) {
      message += 'Description: $severity ';
    }
    return message;
  }
}
