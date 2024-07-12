import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/connectivity/connectivity_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/api_key/auth_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/delete_confirmation/delete_confirmation_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/locale/locale_cubit.dart';
import 'package:todo_list/config/router/router.dart';
import 'package:todo_list/config/theme/app_theme.dart';
import 'package:todo_list/features/settings/domain/state_management/theme/theme_cubit.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_cubit.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityCubit()..init()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => DeleteConfirmationCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => TodoOperationCubit()),
        BlocProvider(
          create: (context) => TodoListBloc(
            todoRepository: GetIt.I<TodoRepository>(),
            todoOperation: context.read<TodoOperationCubit>(),
          )..add(TodosFetchStarted()),
        ),
      ],
      child: BlocBuilder<LocaleCubit, String>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                title: 'Just Todo It',
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
                routerConfig: appRouter,
              );
            },
          );
        },
      ),
    );
  }
}
