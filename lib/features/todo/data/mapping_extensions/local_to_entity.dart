import 'package:todo_list/features/todo/data/dto/local/local_todo_dto.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

extension LocalToEntity on LocalTodoDto {
  TodoEntity toEntity() {
    return TodoEntity(
      id: id!,
      text: text!,
      importance: importance!,
      deadline: deadline,
      done: done!,
      color: color,
      createdAt: createdAt!,
      changedAt: changedAt!,
      lastUpdatedBy: lastUpdatedBy!,
    );
  }
}
