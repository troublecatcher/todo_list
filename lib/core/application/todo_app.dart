import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../config/config.dart';
import '../../config/l10n/generated/l10n.dart';
import '../../features/settings/settings.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, String>(
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
    );
  }
}
