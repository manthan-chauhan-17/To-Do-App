import 'package:flutter/material.dart';
import 'package:to_do_app/modal/todo.dart';
import 'package:to_do_app/widgets/list_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final toDosList = Todo.toDoList();
  final TextEditingController _toDoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Center(
          child: Text(
            "ToDo App",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal(
            context,
            controller: _toDoController,
            addItem: _addToDoItem,
          );
        },
        backgroundColor: Colors.brown,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: toDosList.isEmpty
          ? const Center(
              child: Text(
                "Add Work To Do \nby clicking at + sign",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (Todo todoo in toDosList)
                  Listtile(
                    todo: todoo,
                    onToDoChange: _handleToDoChange,
                    onDeleteItem: _deleteItem,
                  ),
              ],
            ),
    );
  }

  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _deleteItem(String id) {
    setState(() {
      toDosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String todo) {
    setState(() {
      toDosList.add(
        Todo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: todo),
      );
    });
    _toDoController.clear();
    Navigator.pop(context);
  }
}

void openModal(BuildContext context,
    {required TextEditingController controller, required Function addItem}) {
  showModalBottomSheet(
    context: context,
    elevation: 3.0,
    builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Add word todo",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Add button
              ElevatedButton(
                onPressed: () {
                  addItem(controller.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  shape: const ContinuousRectangleBorder(side: BorderSide.none),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Cancel Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  shape: const ContinuousRectangleBorder(side: BorderSide.none),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}
