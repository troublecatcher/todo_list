import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/connectivity/connectivity_cubit.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';

class ConnectivityIndicator extends StatelessWidget {
  const ConnectivityIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, connectivityState) {
        return Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: Durations.long4,
                color: switch (connectivityState) {
                  ConnectivityOffline _ => context.colorScheme.tertiary,
                  ConnectivityOnline _ => context.customColors.green,
                  ConnectivityInitial _ => context.scaffoldBackgroundColor,
                },
                child: AnimatedSize(
                  duration: Durations.long4,
                  curve: Curves.easeOutCirc,
                  child: SizedBox(
                    height: switch (connectivityState) {
                      ConnectivityInitial _ => 0,
                      _ => null,
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        switch (connectivityState) {
                          ConnectivityOffline _ => S.of(context).offlineMode,
                          ConnectivityOnline _ => S.of(context).backOnline,
                          ConnectivityInitial _ => '',
                        },
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
