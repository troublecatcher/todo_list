import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_list/config/service_locator/service_locator.dart';
import 'package:todo_list/core/application/todo_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env');
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(const TodoApp());
}
