import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/features/todo/data/todo_repository_impl.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
import 'package:todo_list/features/todo/domain/todo_bloc.dart';
import 'package:todo_list/features/todo/data/todo_repository.dart';

class IsarService {
  Future<TodoBloc> initializeBloc() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [TodoSchema],
      directory: dir.path,
    );

    final todoRepository = TodoRepositoryImpl(isar);
    return TodoBloc(
      getTodos: GetTodos(todoRepository),
      addTodo: AddTodo(todoRepository),
      updateTodo: UpdateTodo(todoRepository),
      deleteTodoById: DeleteTodoById(todoRepository),
    );
  }
}
