import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list/config/logging/navigation_logger.dart';
import 'package:todo_list/config/theme/app_theme.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/services/service_locator.dart';
import 'package:todo_list/features/todo/data/repository/remote_todo_repository.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/todo_all_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_single_screen.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';
import 'package:todo_list/features/todo/data/repository/local_todo_repository.dart';

import 'package:todo_list/core/services/isar_service.dart';
import 'package:todo_list/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FormattingHelper.init();

  final isar = await IsarService().initIsar();
  await ServiceLocator.setupSharedPreferencesService();

  final networkRepository = RemoteTodoRepository();
  final persistenceRepository = LocalTodoRepository(isar);

  runApp(
    BlocProvider(
      create: (context) => TodoListBloc(
        remote: networkRepository,
        local: persistenceRepository,
      )..add(FetchTodos()),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JUST TODO IT',
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      navigatorObservers: [
        NavigationLogger(),
      ],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => const TodoAllScreen(),
              settings: settings,
            );
          case '/todo':
            return MaterialPageRoute(
              builder: (_) =>
                  TodoSingleScreen(action: settings.arguments as TodoAction),
              settings: settings,
            );

          default:
            return null;
        }
      },
    );
  }
}
