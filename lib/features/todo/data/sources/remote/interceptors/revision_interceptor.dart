part of '../remote_source/remote_todo_source_impl.dart';

class _RevisionInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final revision = GetIt.I<PreferencesService>().revision;
    options.headers['X-Last-Known-Revision'] = revision.value;
    return handler.next(options);
  }
}
