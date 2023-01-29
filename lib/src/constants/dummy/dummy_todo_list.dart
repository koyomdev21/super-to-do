import 'package:super_to_do/src/features/home/domain/todo_response.dart';

var dummyToDoList = ToDoResponse(
  data: ToDoDataResponse(
    todos: [
      ToDo(
        id: 1,
        title: "Service 1",
        image:
            "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80",
      ),
      ToDo(
        id: 2,
        title: "Service 2",
        image:
            "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80",
      ),
      ToDo(
        id: 3,
        title: "Service 3",
        image:
            "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80",
      ),
    ],
  ),
);
