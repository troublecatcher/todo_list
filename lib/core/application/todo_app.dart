import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list/config/flavor/flavor.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/config/navigation/navigation.dart';
import 'package:todo_list/config/theme/app_theme/app_theme.dart';
import 'package:todo_list/features/settings/domain/state_management/locale/locale_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/theme/theme_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type_provider.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/tablet_layout/tablet_layout_cubit.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutTypeProvider(
      layoutType: MediaQuery.of(context).size.shortestSide > 600
          ? LayoutType.tablet
          : LayoutType.mobile,
      child: BlocProvider(
        create: (context) => TabletLayoutCubit(),
        child: BlocBuilder<LocaleCubit, String>(
          builder: (context, locale) {
            return BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return MaterialApp.router(
                  title: 'Just Todo It',
                  theme: AppTheme.getLightTheme(),
                  darkTheme: AppTheme.getDarkTheme(),
                  themeMode: themeMode,
                  debugShowCheckedModeBanner: appFlavor == Flavor.dev.name,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  locale: Locale(locale),
                  routerConfig: router,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
