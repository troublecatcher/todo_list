import 'package:dio/dio.dart';

class NetworkService {
  final String _baseUrl = 'https://beta.mrdekk.ru/todo/list';
  final String _authToken = 'Miriel';

  Dio initDio() => Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {
            'Authorization': 'Bearer $_authToken',
          },
        ),
      );
}
