import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/widgets/dialog_box.dart';
import 'package:todo_app/widgets/toDo_list.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  String dateTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final _selectDate = TextEditingController();
  DateTime checkDate = DateTime.now();
  bool _isScroll = true;
  final ScrollController _scrollController = ScrollController();

  List toDoList = [
    ["Task 1", false, DateFormat('dd/MM/yyyy').format(DateTime.now())],
    ["Task 2", true, DateFormat('dd/MM/yyyy').format(DateTime.now())]
  ];

  void datePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => SizedBox(
              height: 240,
              child: CupertinoDatePicker(
                backgroundColor: Colors.white,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    checkDate = newDateTime;
                    dateTime = DateFormat('dd/MM/yyyy').format(newDateTime);
                    _selectDate.text = dateTime;
                  });
                },
              ),
            ));
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: ((context) {
          return DialogBox(
            controller: _controller,
            selectDate: _selectDate,
            onSaved: () {
              setState(() {
                if (_controller.text.isEmpty) {
                  EasyLoading.showError('Task name is empty');
                  return createNewTask();
                }
                if (_selectDate.text.isEmpty) {
                  EasyLoading.showError('Deadline is empty');
                  return createNewTask();
                }

                toDoList
                    .add([_controller.text, checkDeadline(), _selectDate.text]);
                _controller.clear();
                _selectDate.clear();
                EasyLoading.showSuccess('Task added successfully');
              });
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
            },
            datePicker: (() {
              setState(() {
                datePicker();
              });
            }),
          );
        }));
  }

  bool checkDeadline() {
    if (checkDate.add(Duration(days: 1)).isBefore(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  void editTasks(index) {
    showDialog(
        context: context,
        builder: ((context) {
          return DialogBox(
            controller: _controller,
            selectDate: _selectDate,
            onSaved: () {
              setState(() {
                if (_controller.text.isEmpty) {
                  EasyLoading.showError('Task name is empty');
                  return createNewTask();
                }
                if (_selectDate.text.isEmpty) {
                  EasyLoading.showError('Deadline is empty');
                  return createNewTask();
                }

                toDoList[index][0] = _controller.text;
                toDoList[index][1] = checkDeadline();
                toDoList[index][2] = _selectDate.text;
                _controller.clear();
                _selectDate.clear();
                EasyLoading.showSuccess('Task edited successfully');
              });
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
            },
            datePicker: (() {
              setState(() {
                datePicker();
              });
            }),
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isScroll = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isScroll = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text('TO DO')),
          elevation: 2,
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoList(
              isCheck: toDoList[index][1],
              taskName: toDoList[index][0],
              deadline: toDoList[index][2].toString(),
              onChanged: (value) {
                setState(() {
                  toDoList[index][1] = !toDoList[index][1];
                });
              },
              deleteTask: (context) {
                showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: const Text('Please Confirm'),
                        content: const Text('Are you sure to remove the task?'),
                        actions: [
                          // The "Yes" button
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  toDoList.removeAt(index);
                                });
                                // Close the dialog
                                Navigator.pop(ctx);
                                EasyLoading.showSuccess('Task deleted successfully');
                              },
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.pop(ctx);
                              },
                              child: const Text('No'))
                        ],
                      );
                    });
              },
              editTask: (context) {
                setState(() {
                  _controller.text = toDoList[index][0];
                  _selectDate.text = toDoList[index][2];
                  editTasks(index);
                  // createNewTask();
                  // toDoList.removeAt(index);
                });
              },
            );
          },
        ),
        floatingActionButton: _isScroll
            ? FloatingActionButton.extended(
                onPressed: (() {
                  createNewTask();
                }),
                label: const Text(
                  'Add a new Task',
                  style: TextStyle(fontSize: 16),
                ),
                icon: const Icon(Icons.add),
                elevation: 2,
              )
            : FloatingActionButton(
                onPressed: (() {
                  createNewTask();
                }),
                child: const Icon(Icons.add),
              ),
      ),
    );
  }
}
