import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/connectivity/connectivity_cubit.dart';
import 'package:todo_list/config/connectivity/connectivity_state.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/generated/l10n.dart';

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
              child: AnimatedSize(
                duration: Durations.long4,
                curve: Curves.easeOutCirc,
                child: AnimatedContainer(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  duration: Durations.medium1,
                  height: switch (connectivityState) {
                    ConnectivityInitial _ => 0,
                    _ => null,
                  },
                  color: switch (connectivityState) {
                    ConnectivityOffline _ => context.colorScheme.tertiary,
                    ConnectivityOnline _ => context.customColors.green,
                    ConnectivityInitial _ => null,
                  },
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
          ],
        );
      },
    );
  }
}
