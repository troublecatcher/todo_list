import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/common/header/done_todo_count_widget.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/common/header/settings_button.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/common/header/visibility_toggle/visibility_toggle_button.dart';

class TabletHeader extends StatelessWidget implements PreferredSizeWidget {
  const TabletHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(116);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 116,
      flexibleSpace: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<TodoListBloc, TodoState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: Text(
                        switch (state is TodoLoadInProgress) {
                          true => S.of(context).loading,
                          false => S.of(context).homeHeaderTitle,
                        },
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: Duration.zero,
                  height: 24,
                  child: const DoneTodoCountWidget(),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                VisibilityToggleButton(collapsePercent: 1),
                SettingsButton(collapsePercent: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
