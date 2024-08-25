import 'package:flutter/material.dart';
import 'package:to_do_app/modal/todo.dart';

class Listtile extends StatelessWidget {
  const Listtile({
    super.key,
    required this.todo,
    required this.onToDoChange,
    required this.onDeleteItem,
  });

  final Todo todo;
  final onToDoChange;
  final onDeleteItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        tileColor: Colors.white,
        leading: todo.isDone!
            ? const Icon(
                Icons.check_box,
                color: Colors.brown,
              )
            : const Icon(
                Icons.check_box_outline_blank,
                color: Colors.brown,
              ),
        title: Text(
          todo.todoText!,
          style: todo.isDone!
              ? const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                  decoration: TextDecoration.lineThrough)
              : const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
