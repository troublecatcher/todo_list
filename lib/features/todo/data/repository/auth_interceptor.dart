import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = GetIt.I<SharedPreferencesService>();
    final String? authHeader =
        prefs.bearer ?? (prefs.oauth ?? dotenv.env['auth']);
    options.headers['Authorization'] = authHeader;
    options.headers['X-Last-Known-Revision'] = prefs.revision;
    return handler.next(options);
  }
}
