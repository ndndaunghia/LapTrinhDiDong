import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoList extends StatelessWidget {
  var isCheck;
  final String taskName;
  final String? deadline;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  Function(BuildContext)? editTask;

  ToDoList({
    super.key,
    required this.isCheck,
    required this.taskName,
    required this.deadline,
    required this.onChanged,
    required this.deleteTask,
    required this.editTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0, bottom: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete_forever,
              backgroundColor: Colors.red.shade600,
              borderRadius: BorderRadius.circular(8),
            )
          ],
        ),
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: editTask,
              icon: Icons.edit,
              backgroundColor: Colors.yellow.shade600,
              borderRadius: BorderRadius.circular(8),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isCheck ? Colors.red : Colors.blue[600],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Checkbox(
                value: isCheck,
                onChanged: onChanged,
                activeColor: Colors.black54,
              ),
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 16,
                      color: isCheck ? Colors.black : Colors.white,
                      decoration: isCheck
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
              Text(
                deadline!,
                style: TextStyle(
                    fontSize: 16,
                    color: isCheck ? Colors.black : Colors.white,
                    decoration: isCheck
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
