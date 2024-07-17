import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/core/ui/layout/layout_constants.dart';
import 'package:todo_list/core/ui/widget/custom_back_button.dart';
import 'package:todo_list/features/settings/domain/state_management/auth/auth_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/delete_confirmation/delete_confirmation_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/duck/duck_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/locale/locale_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/theme/theme_cubit.dart';
import 'package:todo_list/features/settings/presentation/widgets/api_key_change_tile.dart';

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
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 5,
        leading: const CustomBackButton(),
        title: Text(
          S.of(context).settings,
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
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
                                  S.delegate.supportedLocales.length,
                                  (index) {
                                    final String lang = S.delegate
                                        .supportedLocales[index].languageCode;
                                    return DropdownMenuItem(
                                      value: lang,
                                      child: Text(lang),
                                    );
                                  },
                                ),
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
                    BlocBuilder<DeleteConfirmationCubit, bool>(
                      builder: (context, confirm) {
                        return SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(S.of(context).confirmTodoDeletion),
                          value: confirm,
                          onChanged: (value) => context
                              .read<DeleteConfirmationCubit>()
                              .set(value),
                        );
                      },
                    ),
                    BlocBuilder<DuckCubit, bool>(
                      builder: (context, confirm) {
                        return SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(S.of(context).duck),
                          value: confirm,
                          onChanged: (value) =>
                              context.read<DuckCubit>().set(value),
                        );
                      },
                    ),
                    Text(
                      S.of(context).apiKey,
                      style: context.textTheme.titleMedium,
                    ),
                    const ApiKeyChangeTile(),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return CustomButtonBase(
                          onPressed: state.source != AuthSource.env
                              ? () async => await context
                                  .read<AuthCubit>()
                                  .set(AuthSource.env, '')
                              : null,
                          child: Text(S.of(context).useEnvFile),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
