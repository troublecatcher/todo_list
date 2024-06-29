import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list/config/locale/locale_cubit.dart';
import 'package:todo_list/config/logger/navigation_logger.dart';
import 'package:todo_list/config/theme/app_theme.dart';
import 'package:todo_list/config/theme/theme_cubit.dart';
import 'package:todo_list/features/settings/screen/settings_screen.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/todo_all_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_single_screen.dart';
import 'package:todo_list/generated/l10n.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, String>(
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: 'JUST TODO IT',
              theme: AppTheme.getLightTheme(),
              darkTheme: AppTheme.getDarkTheme(),
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(locale),
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
                      builder: (_) => TodoSingleScreen(
                          action: settings.arguments as TodoAction),
                      settings: settings,
                    );
                  case '/settings':
                    return MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    );
                  default:
                    return null;
                }
              },
            );
          },
        );
      },
    );
  }
}
