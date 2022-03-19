import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/services/notifyService.dart';

import '../../controllers/taskController.dart';
import '../../widgets/taskCard.dart';

class todayPage extends StatefulWidget {
  const todayPage({Key? key}) : super(key: key);

  @override
  State<todayPage> createState() => _todayPageState();
}

class _todayPageState extends State<todayPage> {
  final _taskController = Get.put(taskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
        child: Expanded(
          child: Center(
            child: Obx(
              () => ListView.builder(
                  itemCount: _taskController.taskList.length,
                  itemBuilder: (_, index) {
                    if (_taskController.taskList[index].date ==
                        DateFormat.yMd().format(DateTime.now())) {
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
      ),
    );
  }
}

class _selectedDate {}
