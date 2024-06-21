import 'package:flutter/material.dart';
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
      items: TodoPriority.values
          .map((TodoPriority priority) => PopupMenuItem<TodoPriority>(
                value: priority,
                child: Text(
                  priority.displayName,
                  style: switch (priority) {
                    TodoPriority.none => null,
                    TodoPriority.low => null,
                    TodoPriority.high => const TextStyle(color: Colors.red),
                  },
                ),
              ))
          .toList(),
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.close_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: 'Что надо сделать...',
                    ),
                    minLines: 1,
                    maxLines: null,
                  ),
                ),
              ),
              Builder(
                builder: (ctx) {
                  return ListTile(
                    title: const Text('Важность'),
                    subtitle: Text(priority.displayName),
                    onTap: () => _onPriorityTileTap(ctx),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Сделать до'),
                  Switch(
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
                ],
              ),
              if (deadline != null) Text(deadline!.toIso8601String()),
              TextButton(
                onPressed: switch (widget.action) {
                  CreateTodo _ => null,
                  EditTodo _ => () => showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Уверены?'),
                          content: const Text('Хотите удалить это дело?'),
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
                child: const Row(
                  children: [
                    Icon(Icons.delete),
                    Text('Удалить'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
