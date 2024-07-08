import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/services/settings/controllers/auth/auth_cubit.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/core/ui/layout/layout_constants.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';

class ApiKeyChangeTile extends StatefulWidget {
  const ApiKeyChangeTile({super.key});

  @override
  State<ApiKeyChangeTile> createState() => _ApiKeyChangeTileState();
}

class _ApiKeyChangeTileState extends State<ApiKeyChangeTile> {
  final controller = TextEditingController();
  final List<String> manualApiKeyTypes = ['Bearer', 'OAuth'];
  late String currentManualApiKeyType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authCubit = context.read<AuthCubit>();
    if (authCubit.state.source == AuthSource.env) {
      currentManualApiKeyType = manualApiKeyTypes.first;
      controller.text = '';
    } else {
      currentManualApiKeyType = authCubit.state.key.split(' ')[0];
      controller.text = authCubit.state.key.split(' ')[1];
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) => didChangeDependencies(),
      builder: (context, state) {
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
              Row(
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      borderRadius: LayoutConstants.borderRadius,
                      value: currentManualApiKeyType,
                      items: manualApiKeyTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                      onChanged: state.source == AuthSource.env
                          ? (value) => setState(
                                () => currentManualApiKeyType = value as String,
                              )
                          : null,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      enabled: state.source == AuthSource.env,
                      controller: controller,
                    ),
                  ),
                ],
              ),
              CustomButtonBase(
                onPressed: state.source == AuthSource.env
                    ? () async => await context.read<AuthCubit>().set(
                          AuthSource.manual,
                          '$currentManualApiKeyType ${controller.text}',
                        )
                    : null,
                child: Text(S.of(context).save),
              ),
            ],
          ),
        );
      },
    );
  }
}
