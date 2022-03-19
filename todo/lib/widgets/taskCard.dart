import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/taskController.dart';
import '../models/taks.dart';

class TaskTile extends StatefulWidget {
  final Task? task;
  final Function? onDelete;
  final Function? updateList;
  const TaskTile(this.task, this.onDelete, this.updateList, {Key? key})
      : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final taskController _taskController = Get.put(taskController());
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(widget.task?.color ?? 0),
        ),
        child: Row(children: [
          Center(
              child: InkWell(
            onTap: () {
              _completeMessage();
              setState(() {
                _value = !_value;
              });
              Future.delayed(const Duration(milliseconds: 500), () {
                widget.onDelete!();
                widget.updateList!();
                _value = !_value;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.backgroundColor,
                  border: Border.all(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: _value
                    ? Icon(
                        Icons.check,
                        size: 20.0,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        size: 20.0,
                        color: context.theme.backgroundColor,
                      ),
              ),
            ),
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task?.title ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.grey[200],
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${widget.task!.date}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${widget.task!.time}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  widget.task?.description ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _completeMessage() {
    Get.snackbar(
      "Completed",
      "Your task has been done",
      duration: Duration(milliseconds: 1000),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: context.theme.backgroundColor,
      icon: Icon(Icons.check_circle_outline, color: Colors.green),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Colors.red[400];
      case 1:
        return Colors.green[400];
      case 2:
        return Color(0xFF4e5ae8);
      case 3:
        return Colors.orange[400];
      default:
        return Colors.pink[400];
    }
  }
}
