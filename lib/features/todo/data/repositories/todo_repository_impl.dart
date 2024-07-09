import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/features/todo/data/models/local/local_todo.dart';
import 'package:todo_list/features/todo/data/models/remote/remote_todo.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/settings_service.dart';

part '../mappers/entity_mapper.dart';
part '../mappers/local_mappers.dart';
part '../mappers/remote_mappers.dart';

class TodoRepositoryImpl implements TodoRepository {
  final RemoteTodoSource _remote;
  final LocalTodoSource _local;
  final RevisionSetting _revision;

  TodoRepositoryImpl({
    required RemoteTodoSource remote,
    required LocalTodoSource local,
  })  : _remote = remote,
        _local = local,
        _revision = GetIt.I<SettingsService>().revision;

  @override
  Future<List<Todo>> fetchTodos() async {
    try {
      final int localRevision = _revision.value;
      Log.i('Fetching todos remote');
      final (List<RemoteTodo> remoteTodos, int remoteRevision) =
          await _remote.getTodos();
      if (remoteRevision < localRevision) {
        final List<LocalTodo> localTodos = await _local.getTodos();
        await _remote.putFresh(localTodos.toRemoteTodos());
        await _revision.set(remoteRevision);
        Log.w('Local revision won, overwritten remote');
        return localTodos.toEntities();
      } else {
        await _local.putFresh(remoteTodos.toLocalTodos());
        await _revision.set(remoteRevision);
        Log.w('Remote revision won, overwritten local');
        return remoteTodos.toEntities();
      }
    } catch (e, s) {
      Log.e('Error fetching todos from remote: $e, $s');
      Log.i('Fetching todos local');
      try {
        final List<LocalTodo> localTodos = await _local.getTodos();
        return localTodos.toEntities();
      } catch (e, s) {
        Log.e('Error fetching todos from local: $e, $s');
        rethrow;
      }
    }
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await _executeAction(
      remoteAction: () => _remote.addTodo(todo.toRemote()),
      localAction: () => _local.addTodo(todo.toLocal()),
    );
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _executeAction(
      remoteAction: () => _remote.updateTodo(todo.toRemote()),
      localAction: () => _local.updateTodo(todo.toLocal()),
    );
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _executeAction(
      remoteAction: () => _remote.deleteTodo(todo.toRemote()),
      localAction: () => _local.deleteTodo(todo.toLocal()),
    );
  }

  Future<void> _executeAction({
    required Future<void> Function() remoteAction,
    required Future<void> Function() localAction,
  }) async {
    bool incremented = false;
    try {
      await remoteAction();
      await _revision.increment();
      incremented = true;
    } catch (e, s) {
      Log.e('Error in remote: $e, $s');
    }
    try {
      await localAction();
      if (!incremented) await _revision.increment();
    } catch (e, s) {
      Log.e('Error in local: $e, $s');
      rethrow;
    }
  }
}
