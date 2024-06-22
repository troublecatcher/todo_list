import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/common/ui/custom_card.dart';
import 'package:todo_list/common/ui/custom_icon_button.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_action.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_result.dart';

class NewTodoScreen extends StatefulWidget {
  final TodoAction action;
  const NewTodoScreen({super.key, required this.action});

  @override
  State<NewTodoScreen> createState() => _NewTodoScreenState();
}

class _NewTodoScreenState extends State<NewTodoScreen> {
  final contentController = TextEditingController();
  TodoPriority priority = TodoPriority.none;
  DateTime? deadline;
  int? id;

  @override
  void initState() {
    super.initState();
    final action = widget.action;
    if (action is EditTodo) {
      final todo = action.todo;
      contentController.text = todo.content!;
      priority = todo.priority;
      deadline = todo.deadline;
      id = todo.id;
    }
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  Future<void> _showPriorityMenu(BuildContext context, Offset offset) async {
    final selectedPriority = await showMenu<TodoPriority>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx + 1,
        offset.dy + 1,
      ),
      items: TodoPriority.values.map((TodoPriority priority) {
        final menuItemStyle = Theme.of(context).textTheme.bodyMedium;
        return PopupMenuItem<TodoPriority>(
          value: priority,
          child: Text(
            priority.displayName,
            style: switch (priority) {
              TodoPriority.none => menuItemStyle,
              TodoPriority.low => menuItemStyle,
              TodoPriority.high =>
                menuItemStyle!.copyWith(color: AppColors.red),
            },
          ),
        );
      }).toList(),
    );

    if (selectedPriority != null) {
      setState(() {
        priority = selectedPriority;
      });
    }
  }

  void _onPriorityTileTap(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    _showPriorityMenu(
        context, Offset(offset.dx, offset.dy + renderBox.size.height));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 5,
        leading: CustomIconButton(
          icon: Icons.close,
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        // leading: IconButton(
        // onPressed: () => Navigator.of(context).pop(),
        //   icon: Icon(
        //     Icons.close_rounded,
        //     color: Theme.of(context).colorScheme.secondary,
        //   ),
        // ),
        actions: [
          TextButton(
            onPressed: () {
              final todo = Todo(
                content: contentController.text,
                priority: priority,
                deadline: deadline,
                isDone: switch (widget.action) {
                  CreateTodo _ => false,
                  EditTodo action => action.todo.isDone,
                },
              );
              switch (widget.action) {
                case CreateTodo _:
                  Navigator.of(context).pop(todo);
                  break;
                case EditTodo _:
                  Navigator.of(context).pop(EditedTodo(todo: todo));
                  break;
              }
            },
            child: const Text('СОХРАНИТЬ'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CustomCard(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: contentController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Что надо сделать...',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                        ),
                        minLines: 4,
                        maxLines: null,
                      ),
                    ),
                    Builder(
                      builder: (ctx) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Приоритет',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subtitle: Text(priority.displayName),
                          onTap: () => _onPriorityTileTap(ctx),
                        );
                      },
                    ),
                    const Divider(height: 0),
                    AnimatedSize(
                      duration: Durations.medium1,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                        title: const Text('Сделать до'),
                        subtitle: deadline != null
                            ? Text(deadline!.toIso8601String())
                            : null,
                        subtitleTextStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                        trailing: Switch(
                          value: deadline != null,
                          onChanged: (value) async {
                            if (value) {
                              final newDeadline = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (newDeadline != null) {
                                deadline = newDeadline;
                              }
                            } else {
                              deadline = null;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton(
                  onPressed: switch (widget.action) {
                    CreateTodo _ => null,
                    EditTodo _ => () => showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              'Уверены, что хотите удалить дело?',
                            ),
                            content: const Text(
                              'Это действие необратимо',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('НЕТ'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                  ..pop()
                                  ..pop(DeletedTodo()),
                                child: const Text('ДА'),
                              ),
                            ],
                          ),
                        ),
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        color: AppColors.red,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Удалить',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
