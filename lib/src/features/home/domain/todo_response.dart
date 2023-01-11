import 'dart:convert';

import 'package:super_to_do/src/features/authentication/domain/authentication_response.dart';

class ToDo extends BaseResponse {
  int? id;
  String? title;
  String? image;
  bool? completed;
  ToDo({
    this.id,
    this.title,
    this.image,
    this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'completed': completed,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id']?.toInt(),
      title: map['title'],
      image: map['image'],
      completed: map['completed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source));
}

class ToDoDataResponse extends BaseResponse {
  List<ToDo> todos;
  ToDoDataResponse({
    required this.todos,
  });

  Map<String, dynamic> toMap() {
    return {
      'todos': todos.map((x) => x.toMap()).toList(),
    };
  }

  factory ToDoDataResponse.fromMap(Map<String, dynamic> map) {
    return ToDoDataResponse(
      todos: List<ToDo>.from(map['todos']?.map((x) => ToDo.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoDataResponse.fromJson(String source) =>
      ToDoDataResponse.fromMap(json.decode(source));
}

class ToDoResponse extends BaseResponse {
  ToDoDataResponse data;
  ToDoResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
    };
  }

  factory ToDoResponse.fromMap(Map<String, dynamic> map) {
    return ToDoResponse(
      data: ToDoDataResponse.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoResponse.fromJson(String source) =>
      ToDoResponse.fromMap(json.decode(source));
}
