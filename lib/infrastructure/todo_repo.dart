import 'dart:io';

import 'package:logger/logger.dart';
import 'package:todo/domain/todo.dart';

import '../domain/i_todo_repo.dart';

class TodoRepo extends ITodoRepo {
  final List<Todo> firebase = [
    // Todo(
    //     title: "aa",
    //     details: "ddd",
    //     createdAt: DateTime.now(),
    //     image:
    //         "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
  ];
  @override
  Future<void> addTodo({required Todo todo}) async {
    await Future.delayed(Duration(seconds: 1));

    // final List<Todo> todos = await getTodo();
    // todos.add(todo);
    // // TODO: implement addTodo

    // final mapList = todos.map((e) => e.toMap());
    firebase.add(todo);
  }

  @override
  Future<List<Todo>> getTodo() async {
    await Future.delayed(Duration(seconds: 2));
    if (firebase.isNotEmpty) {
      final data = firebase;
      Logger().i("getting ");
      Logger().i(data);
      if (data is List) {
        // final todos = data;

        return data;
      } else {
        return [];
      }
    } else {
      return [];
    }
    // TODO: implement getTodo
    throw UnimplementedError();
  }
}
