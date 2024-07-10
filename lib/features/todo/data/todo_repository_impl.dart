import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/features/todo/data/models/local/local_todo.dart';
import 'package:todo_list/features/todo/data/models/remote/remote_todo.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/settings_service.dart';

part 'mappers/entity_mappers.dart';
part 'mappers/local_mappers.dart';
part 'mappers/remote_mappers.dart';

class TodoRepositoryImpl implements TodoRepository {
  final RemoteTodoSource _remote;
  final LocalTodoSource _local;
  final RevisionSetting _revision;
  final InitSyncSetting _initSync;

  TodoRepositoryImpl({
    required RemoteTodoSource remote,
    required LocalTodoSource local,
  })  : _remote = remote,
        _local = local,
        _revision = GetIt.I<SettingsService>().revision,
        _initSync = GetIt.I<SettingsService>().initSync;

  @override
  Future<List<Todo>> fetchTodos() async {
    final localRevision = _revision.value;
    final (remoteTodos, remoteRevision) = await _tryGetRemoteTodos();
    if (_initSync.value) {
      return await _handleRevisions(remoteRevision, localRevision, remoteTodos);
    } else {
      await _initSync.set(true);
      final localTodos = await _tryGetLocalTodos();
      if (localTodos.isNotEmpty) {
        final mergedTodos = remoteTodos.toEntities()
          ..addAll(localTodos.toEntities());
        await _remote.putFresh(mergedTodos.toRemoteTodos());
        await _local.putFresh(mergedTodos.toLocalTodos());
        return mergedTodos;
      } else {
        return remoteTodos.toEntities();
      }
    }
  }

  Future<List<Todo>> _handleRevisions(
    int remoteRevision,
    int localRevision,
    List<RemoteTodo> remoteTodos,
  ) async {
    if (remoteRevision < localRevision) {
      final localTodos = await _tryGetLocalTodos();
      await _remote.putFresh(localTodos.toRemoteTodos());
      await _revision.set(localRevision + 1);
      Log.w('Local revision won, overwritten remote');
      return localTodos.toEntities();
    } else {
      await _local.putFresh(remoteTodos.toLocalTodos());
      await _revision.set(remoteRevision);
      Log.w('Remote revision won, overwritten local');
      return remoteTodos.toEntities();
    }
  }

  Future<(List<RemoteTodo>, int)> _tryGetRemoteTodos() async {
    try {
      Log.i('Fetching todos remote');
      final (remoteTodos, revision) = await _remote.getTodos();
      return (remoteTodos, revision);
    } catch (e, s) {
      Log.e('Error fetching todos from remote: $e, $s');
      rethrow;
    }
  }

  Future<List<LocalTodo>> _tryGetLocalTodos() async {
    try {
      Log.i('Fetching todos local');
      final List<LocalTodo> localTodos = await _local.getTodos();
      return localTodos;
    } catch (e, s) {
      Log.e('Error fetching todos from local: $e, $s');
      rethrow;
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
