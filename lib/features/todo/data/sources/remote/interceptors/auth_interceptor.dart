part of '../remote_source/remote_todo_source_impl.dart';

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final auth = GetIt.I<SettingsService>().auth;
    final String authHeader = auth.value ?? dotenv.env['auth'] ?? '';
    options.headers['Authorization'] = authHeader;
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _handleUnauthorizedError();
    }
    return handler.next(err);
  }

  Future<void> _handleUnauthorizedError() async {}
}
