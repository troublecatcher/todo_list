import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/api_key/api_key_cubit.dart';
import 'package:todo_list/config/user_interaction/dialog_confirmation_cubit.dart';
import 'package:todo_list/config/locale/locale_cubit.dart';
import 'package:todo_list/config/theme/theme_cubit.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/widget/custom_back_button.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/generated/l10n.dart';

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
                          return DropdownButton(
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
                          return DropdownButton(
                            value: state,
                            items: List.generate(
                              ThemeMode.values.length,
                              (index) {
                                final ThemeMode pref = ThemeMode.values[index];
                                return DropdownMenuItem(
                                  value: pref,
                                  child: Text(pref.name),
                                );
                              },
                            ),
                            onChanged: (value) =>
                                context.read<ThemeCubit>().set(value!),
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
                  BlocBuilder<ApiKeyCubit, ApiKeyState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          ApiKeyItem(
                            type: ApiKeyType.bearer,
                            text: state.type == ApiKeyType.bearer
                                ? state.key
                                : null,
                            currentType: state.type,
                          ),
                          ApiKeyItem(
                            type: ApiKeyType.oauth,
                            text: state.type == ApiKeyType.oauth
                                ? state.key
                                : null,
                            currentType: state.type,
                          )
                        ],
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

class ApiKeyItem extends StatefulWidget {
  final ApiKeyType type;
  final ApiKeyType currentType;
  final String? text;
  const ApiKeyItem({
    super.key,
    required this.type,
    required this.text,
    required this.currentType,
  });

  @override
  State<ApiKeyItem> createState() => _ApiKeyItemState();
}

class _ApiKeyItemState extends State<ApiKeyItem> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.text ?? '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border.all(color: context.dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(widget.type.name),
          TextField(
            controller: controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonBase(
                onPressed: widget.currentType != widget.type
                    ? () async => await context
                        .read<ApiKeyCubit>()
                        .set(widget.type, controller.text)
                    : null,
                child: Text(S.of(context).save),
              ),
              CustomButtonBase(
                onPressed: () async =>
                    await context.read<ApiKeyCubit>().set(ApiKeyType.env, ''),
                child: Text(S.of(context).delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
