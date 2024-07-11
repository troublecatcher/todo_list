import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/core/services/device_info_service.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';

late Todo todo;

class MockDeviceInfoService extends Mock implements DeviceInfoService {}

void main() {
  final now = DateTime.now();
  todo = Todo(
    id: '1',
    text: '123',
    importance: Importance.basic,
    deadline: now,
    done: false,
    color: null,
    createdAt: now,
    changedAt: now,
    lastUpdatedBy: 'ryan gosling',
  );
  group('TodoSingleCubit', () {
    late TodoSingleCubit cubit;
    late MockDeviceInfoService mockDeviceInfoService;

    setUp(() {
      mockDeviceInfoService = MockDeviceInfoService();
      when(() => mockDeviceInfoService.info).thenReturn('mock-device-info');
      GetIt.I.registerSingleton<DeviceInfoService>(mockDeviceInfoService);
      cubit = TodoSingleCubit(todo: todo);
    });

    tearDown(() {
      cubit.close();
      GetIt.I.reset();
    });

    blocTest<TodoSingleCubit, Todo>(
      'changeText должен передавать правильное состояние',
      build: () => cubit,
      act: (cubit) => cubit.changeText('updated'),
      expect: () => [
        predicate<Todo>((state) {
          return state.text == 'updated';
        }),
      ],
    );

    blocTest<TodoSingleCubit, Todo>(
      'changeImportance должен передавать правильное состояние',
      build: () => cubit,
      act: (cubit) => cubit.changeImportance(Importance.important),
      expect: () => [
        predicate<Todo>((state) {
          return state.importance == Importance.important;
        }),
      ],
    );

    blocTest<TodoSingleCubit, Todo>(
      'changeDeadline должен обновлять только дедлайн',
      build: () => cubit,
      act: (cubit) => cubit.changeDeadline(null),
      expect: () => [
        predicate<Todo>((state) {
          return state.id == todo.id &&
              state.text == todo.text &&
              state.importance == todo.importance &&
              state.deadline == null &&
              state.done == todo.done &&
              state.color == todo.color &&
              state.createdAt == todo.createdAt &&
              state.changedAt == todo.changedAt &&
              state.lastUpdatedBy == todo.lastUpdatedBy;
        }),
      ],
    );

    blocTest<TodoSingleCubit, Todo>(
      'changeDeadline должен обновлять только дедлайн',
      build: () => cubit,
      act: (cubit) => cubit.changeDeadline(DateTime(2002, 5, 23)),
      expect: () => [
        predicate<Todo>((state) {
          return state.id == todo.id &&
              state.text == todo.text &&
              state.importance == todo.importance &&
              state.deadline == DateTime(2002, 5, 23) &&
              state.done == todo.done &&
              state.color == todo.color &&
              state.createdAt == todo.createdAt &&
              state.changedAt == todo.changedAt &&
              state.lastUpdatedBy == todo.lastUpdatedBy;
        }),
      ],
    );

    blocTest<TodoSingleCubit, Todo>(
      'assignMetadata с новой задачей должен устанавливать правильные метаданные',
      build: () => cubit,
      act: (cubit) {
        return cubit.assignMetadata(null);
      },
      expect: () => [
        predicate<Todo>((state) {
          return state.id.isNotEmpty &&
              state.createdAt.isSameDate(now) &&
              state.changedAt.isSameDate(now) &&
              state.lastUpdatedBy == 'mock-device-info';
        }),
      ],
    );

    blocTest<TodoSingleCubit, Todo>(
      'assignMetadata с существующей задачей должен сохранять правильные метаданные',
      build: () => cubit,
      act: (cubit) => cubit.assignMetadata(todo),
      expect: () => [
        predicate<Todo>((state) {
          return state.id == todo.id &&
              state.createdAt == todo.createdAt &&
              state.changedAt.isSameDate(DateTime.now()) &&
              state.lastUpdatedBy == 'mock-device-info';
        }),
      ],
    );
  });
}

extension DateTimeExtensions on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
