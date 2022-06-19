import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:todo/aplication/app_state.dart';

import '../domain/i_todo_repo.dart';
import '../domain/todo.dart';
import '../infrastructure/todo_repo.dart';

final appProvider = StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier(TodoRepo());
});

class AppNotifier extends StateNotifier<AppState> {
  ITodoRepo iTodoRepo;
  AppNotifier(this.iTodoRepo)
      : super(const AppState(listOfTodo: [], loading: false));

  loadData() async {
    state = state.copyWith(loading: true);
    final data = await iTodoRepo.getTodo();
    state = state.copyWith(loading: false, listOfTodo: data);
  }

  addTodo(Todo todo) async {
    Logger().i(todo);
    state = state.copyWith(loading: true);
    await iTodoRepo.addTodo(todo: todo);
    loadData();
  }
}
