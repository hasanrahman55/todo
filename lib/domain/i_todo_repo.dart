import 'package:todo/domain/todo.dart';

abstract class ITodoRepo {
  Future<List<Todo>> getTodo();
  Future<void> addTodo({required Todo todo});
}
