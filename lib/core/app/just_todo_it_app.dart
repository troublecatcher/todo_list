import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list/config/logger/navigation_logger.dart';
import 'package:todo_list/config/theme/app_theme.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/todo_all_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_single_screen.dart';
import 'package:todo_list/generated/l10n.dart';

class JustTodoItApp extends StatelessWidget {
  const JustTodoItApp({super.key});

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
