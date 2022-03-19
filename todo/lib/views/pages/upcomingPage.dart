import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/views/theme.dart';

import '../../controllers/taskController.dart';
import '../../widgets/taskCard.dart';

class upcomingPage extends StatefulWidget {
  const upcomingPage({Key? key}) : super(key: key);

  @override
  State<upcomingPage> createState() => _upcomingPageState();
}

class _upcomingPageState extends State<upcomingPage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(taskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: headingTextStyle,
                ),
                Spacer(),
                Text(
                  "Today",
                  style: headingTextStyle,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 70,
                initialSelectedDate: DateTime.now(),
                selectionColor: Color(0xFF4e5ae8),
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                dayTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                onDateChange: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: Obx(
                  () => ListView.builder(
                      itemCount: _taskController.taskList.length,
                      itemBuilder: (_, index) {
                        if (_taskController.taskList[index].date ==
                            DateFormat.yMd().format(_selectedDate)) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                    child: TaskTile(
                                        _taskController.taskList[index],
                                        () => _taskController.delete(
                                            _taskController.taskList[index]),
                                        () => _taskController.getTasks())),
                              ));
                        } else
                          return Container();
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
