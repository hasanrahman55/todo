import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class Todo extends Equatable {
  final String title;
  final String details;
  final DateTime createdAt;
  final File image;

  const Todo({
    required this.title,
    required this.details,
    required this.createdAt,
    required this.image,
  });

  Todo copyWith({
    String? title,
    String? details,
    DateTime? createdAt,
    File? image,
  }) {
    return Todo(
      title: title ?? this.title,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'details': details,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'image': image,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] ?? '',
      details: map['details'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(title: $title, details: $details, createdAt: $createdAt, image: $image)';
  }

  @override
  List<Object> get props => [title, details, createdAt, image];
}
