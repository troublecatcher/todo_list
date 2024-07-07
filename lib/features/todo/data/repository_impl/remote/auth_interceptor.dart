import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/preferences/preferences_service/preferences_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final auth = GetIt.I<PreferencesService>().auth;
    final revision = GetIt.I<PreferencesService>().revision;
    final String authHeader = auth.value ?? dotenv.env['auth'] ?? '';
    options.headers['Authorization'] = authHeader;
    options.headers['X-Last-Known-Revision'] = revision.value;
    return handler.next(options);
  }
}
