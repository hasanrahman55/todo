import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../domain/todo.dart';

class AppState extends Equatable {
  final bool loading;
  final List<Todo> listOfTodo;
  const AppState({
    required this.loading,
    required this.listOfTodo,
  });

  AppState copyWith({
    bool? loading,
    List<Todo>? listOfTodo,
  }) {
    return AppState(
      loading: loading ?? this.loading,
      listOfTodo: listOfTodo ?? this.listOfTodo,
    );
  }

  @override
  List<Object> get props => [loading, listOfTodo];
}
