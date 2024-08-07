import 'package:dio/dio.dart';
import 'package:todo_list/config/log/logger.dart';
import 'package:todo_list/core/services/settings_service.dart';
import 'package:todo_list/features/todo/data/models/remote/unauthorized_exception.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';

import 'models/local/local_todo.dart';
import 'models/remote/remote_todo.dart';

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
    required RevisionSetting revision,
    required InitSyncSetting initSync,
  })  : _remote = remote,
        _local = local,
        _revision = revision,
        _initSync = initSync;

  @override
  Future<List<Todo>> fetchTodos() async {
    final localRevision = _revision.value;
    try {
      Log.i('Fetching todos remote');
      final (remoteTodos, remoteRevision) = await _remote.getTodos();
      if (_initSync.value == true) {
        return await _handleRevisions(
          remoteRevision,
          localRevision,
          remoteTodos,
        );
      } else {
        return await _mergeNeverSyncedTodosWithRemote(
          remoteRevision,
          remoteTodos,
        );
      }
    } catch (e, s) {
      if (_isUnauthorizedError(e)) throw UnauthorizedException();
      Log.e('Error fetching todos from remote: $e, $s');
      return (await _tryGetLocalTodos()).toEntities();
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

  Future<List<Todo>> _mergeNeverSyncedTodosWithRemote(
    int remoteRevision,
    List<RemoteTodo> remoteTodos,
  ) async {
    await _initSync.set(true);
    // await _revision.set(remoteRevision);
    final localTodos = await _tryGetLocalTodos();
    if (localTodos.isNotEmpty) {
      Log.i('Device never synced and there is data, merging...');
      final mergedTodos = remoteTodos.toEntities()
        ..addAll(localTodos.toEntities());
      await _remote.putFresh(mergedTodos.toRemoteTodos());
      await _local.putFresh(mergedTodos.toLocalTodos());
      Log.i(
        'Both sources updated with merged list, revision is ${remoteRevision + 1} everywhere',
      );
      return mergedTodos;
    } else {
      Log.i(
        'Device never synced and there is no data, returning remote. Revision is $remoteRevision everywhere',
      );
      return remoteTodos.toEntities();
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
      if (_isUnauthorizedError(e)) throw UnauthorizedException();
      Log.e('Error in remote: $e, $s');
    }
    try {
      await localAction();
      if (!incremented) await _revision.increment();
    } catch (e, s) {
      Log.e('Error in local: $e, $s');
    }
  }

  bool _isUnauthorizedError(dynamic e) {
    if (e is DioException && e.response?.statusCode == 401) {
      return true;
    }
    return false;
  }
}
