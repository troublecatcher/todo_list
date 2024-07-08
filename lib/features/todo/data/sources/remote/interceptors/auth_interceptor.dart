part of '../remote_source/remote_todo_source_impl.dart';

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final auth = GetIt.I<PreferencesService>().auth;
    final String authHeader = auth.value ?? dotenv.env['auth'] ?? '';
    options.headers['Authorization'] = authHeader;
    return handler.next(options);
  }
}
