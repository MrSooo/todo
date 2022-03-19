import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/taskController.dart';
import 'package:todo/models/taks.dart';
import 'package:todo/views/theme.dart';
import 'package:todo/widgets/inputField.dart';

class addTodoPage extends StatefulWidget {
  const addTodoPage({Key? key}) : super(key: key);

  @override
  State<addTodoPage> createState() => _addTodoPageState();
}

class _addTodoPageState extends State<addTodoPage> {
  final taskController _taskController = Get.put(taskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _alarmTime = DateFormat("HH:mm a").format(DateTime.now()).toString();
  int _selectedReminder = 10;
  List<int> reminderList = [5, 10, 15, 20, 25, 30];

  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Get.isDarkMode ? Colors.white : Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
              child: Column(
            children: [
              inputField(
                hintText: "Enter task tile here",
                title: "Title",
                controller: _titleController,
              ),
              inputField(
                hintText: "Enter task description here",
                title: "Description",
                isDescription: true,
                controller: _descriptionController,
              ),
              inputField(
                  widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _getDateFormPicker();
                    },
                  ),
                  hintText: DateFormat.yMd().format(_selectedDate),
                  title: "Date"),
              inputField(
                hintText: _alarmTime,
                title: "Time",
                widget: IconButton(
                  icon: Icon(
                    Icons.access_time_filled_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getTimeFormPicker();
                  },
                ),
              ),
              inputField(
                hintText: "$_selectedReminder minutes early",
                title: "Reminder",
                widget: DropdownButton(
                  underline: Container(
                    height: 0,
                  ),
                  items: reminderList
                      .map((reminder) => DropdownMenuItem(
                            child: Text(
                              "$reminder minutes",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            value: reminder,
                          ))
                      .toList(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 30,
                  style: headingTextStyle,
                  elevation: 4,
                  onChanged: (int? newVal) {
                    setState(() {
                      _selectedReminder = newVal!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: [
                    Text("Color", style: titleTextStyle),
                    SizedBox(width: 10),
                    Wrap(
                      children: List<Widget>.generate(5, (int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: index == 0
                                  ? Colors.red[400]
                                  : index == 1
                                      ? Colors.green[400]
                                      : index == 2
                                          ? Color(0xFF4e5ae8)
                                          : index == 3
                                              ? Colors.orange[400]
                                              : Colors.pink[400],
                              child: _selectedColor == index
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _validateTask();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF4e5ae8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "+ Add Task",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ])
            ],
          )),
        ));
  }

  _validateTask() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      _addDataToDB();
      Get.back();
    } else if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: context.theme.backgroundColor,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    }
  }

  _getDateFormPicker() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("No date selected");
    }
  }

  _getTimeFormPicker() async {
    final TimeOfDay? _pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));

    if (_pickedTime == null) {
      print("No time selected");
    } else {
      setState(() {
        _alarmTime = _pickedTime.format(context);
      });
    }
  }

  _addDataToDB() async {
    int val = await _taskController.addTask(
        task: Task(
      title: _titleController.text,
      description: _descriptionController.text,
      date: DateFormat.yMd().format(_selectedDate),
      time: _alarmTime,
      reminder: _selectedReminder,
      color: _selectedColor,
    ));
  }
}
