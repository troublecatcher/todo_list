import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/api_key/auth_cubit.dart';
import 'package:todo_list/config/dialog_confirmation/dialog_confirmation_cubit.dart';
import 'package:todo_list/config/l10n/locale_cubit.dart';
import 'package:todo_list/config/theme/theme_cubit.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/layout_constants.dart';
import 'package:todo_list/core/ui/widget/custom_back_button.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/settings/widgets/api_key_change_tile.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final bearerController = TextEditingController();
  final oauthController = TextEditingController();

  @override
  void dispose() {
    bearerController.dispose();
    oauthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: const CustomBackButton(),
            title: Text(
              S.of(context).settings,
              style: context.textTheme.titleMedium,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).language),
                      BlocBuilder<LocaleCubit, String>(
                        builder: (context, state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                              borderRadius: LayoutConstants.borderRadius,
                              value: state,
                              items: List.generate(
                                  S.delegate.supportedLocales.length, (index) {
                                final String lang = S.delegate
                                    .supportedLocales[index].languageCode;
                                return DropdownMenuItem(
                                  value: lang,
                                  child: Text(lang),
                                );
                              }),
                              onChanged: (value) =>
                                  context.read<LocaleCubit>().set(value!),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).theme),
                      BlocBuilder<ThemeCubit, ThemeMode>(
                        builder: (context, state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                              borderRadius: LayoutConstants.borderRadius,
                              value: state,
                              items: List.generate(
                                ThemeMode.values.length,
                                (index) {
                                  final ThemeMode pref =
                                      ThemeMode.values[index];
                                  return DropdownMenuItem(
                                    value: pref,
                                    child: Text(pref.name),
                                  );
                                },
                              ),
                              onChanged: (value) =>
                                  context.read<ThemeCubit>().set(value!),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<DialogConfirmationCubit, bool>(
                    builder: (context, confirm) {
                      return SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(S.of(context).confirmTodoDeletion),
                        value: confirm,
                        onChanged: (value) =>
                            context.read<DialogConfirmationCubit>().set(value),
                      );
                    },
                  ),
                  Text('API key', style: context.textTheme.titleMedium),
                  const ApiKeyChangeTile(),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomButtonBase(
                        onPressed: state.source != AuthSource.env
                            ? () async => await context
                                .read<AuthCubit>()
                                .set(AuthSource.env, '')
                            : null,
                        child: const Text('Restore .env'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
