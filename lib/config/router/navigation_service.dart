import 'package:go_router/go_router.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

class NavigationService {
  final GoRouter _router;

  NavigationService(this._router);

  void goToHome() {
    _router.goNamed('home');
  }

  void goToTodoSingle({Todo? todo}) {
    _router.goNamed('todo', extra: todo);
  }

  void goToSettings() {
    _router.goNamed('settings');
  }

  void pop<T extends Object?>([T? result]) {
    _router.pop(result);
  }
}
