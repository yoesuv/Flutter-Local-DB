/// A domain-level error thrown by repositories.
///
/// Repositories catch infrastructure errors (e.g. `DioException`,
/// `FormatException`, `TypeError`) and rethrow them as a
/// `RepositoryException` so that upper layers (bloc/UI) never need to
/// depend on networking or serialization implementation details.
///
/// The original error is kept in [cause], and the original stack trace is
/// preserved by rethrowing with `Error.throwWithStackTrace`, so callers that
/// do inspect the stack trace still get the frames from the original failure.
class RepositoryException implements Exception {
  const RepositoryException(this.message, {this.cause});

  /// Human-readable description of what went wrong.
  final String message;

  /// The underlying error that was translated (e.g. a `DioException`).
  final Object? cause;

  @override
  String toString() =>
      'RepositoryException: $message'
      '${cause != null ? ' (caused by: $cause)' : ''}';
}
