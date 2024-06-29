import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/locale/locale_cubit.dart';
import 'package:todo_list/config/theme/theme_cubit.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/custom_back_button.dart';
import 'package:todo_list/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                            final String lang =
                                S.delegate.supportedLocales[index].languageCode;
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
                const Text('API Key'),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text('Bearer'),
                            Radio(
                              value: '1',
                              groupValue: '4',
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: '1',
                              groupValue: '4',
                              onChanged: (value) {},
                            ),
                            const Text('Bearer .env'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('OAuth'),
                    Radio(
                      value: '1',
                      groupValue: '4',
                      onChanged: (value) {},
                    ),
                    const Expanded(
                      child: TextField(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('OAuth .env'),
                    Radio(
                      value: '1',
                      groupValue: '4',
                      onChanged: (value) {},
                    ),
                    const Expanded(
                      child: TextField(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
