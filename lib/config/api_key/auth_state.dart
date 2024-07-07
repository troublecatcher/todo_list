import 'package:todo_list/config/api_key/auth_type.dart';

final class AuthState {
  final AuthSource source;
  final String key;

  AuthState({required this.source, required this.key});
}
