import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

class Analytics {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logPageVisit(String pageName) async {
    _analytics.logEvent(
      name: 'page_visit',
      parameters: {'page_name': pageName},
    );
  }

  static Future<void> logPageLeave(String pageName) async {
    _analytics.logEvent(
      name: 'page_leave',
      parameters: {'page_name': pageName},
    );
  }

  static Future<void> logCreateTodo(Todo todo) async {
    _analytics.logEvent(
      name: 'create_todo',
      parameters: todo.toMap(),
    );
  }

  static Future<void> logUpdateTodo(Todo todo) async {
    _analytics.logEvent(
      name: 'update_todo',
      parameters: todo.toMap(),
    );
  }

  static Future<void> logDeleteTodo(Todo todo) async {
    _analytics.logEvent(
      name: 'delete_todo',
      parameters: todo.toMap(),
    );
  }
}
