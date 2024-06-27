import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';

class PersistenceService {
  Future<Isar> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [TodoSchema],
      directory: dir.path,
    );
    return isar;
  }
}
