import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/taskController.dart';

import '../../services/notifyService.dart';
import '../../widgets/taskCard.dart';

class allPage extends StatefulWidget {
  const allPage({Key? key}) : super(key: key);

  @override
  State<allPage> createState() => _allPageState();
}

class _allPageState extends State<allPage> {
  final _taskController = Get.put(taskController());
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = notificationHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

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
                    DateTime time = DateFormat.jm()
                        .parse(_taskController.taskList[index].time.toString());
                    time = time.subtract(Duration(
                        minutes:
                            _taskController.taskList[index].reminder!.toInt()));
                    var myTime = DateFormat("HH:mm").format(time);

                    DateTime date = DateFormat.yMd()
                        .parse(_taskController.taskList[index].date.toString());
                    bool check = date.isAfter(DateTime.now());
                    if (date.isAfter(DateTime.now()) ||
                        (DateTime.now().hour < time.hour) ||
                        (DateTime.now().hour == time.hour &&
                            DateTime.now().minute < time.minute)) {
                      notifyHelper.scheduledNotification(
                        int.parse(_taskController.taskList[index].date
                            .toString()
                            .split("/")[1]),
                        int.parse(_taskController.taskList[index].date
                            .toString()
                            .split("/")[0]),
                        int.parse(_taskController.taskList[index].date
                            .toString()
                            .split("/")[2]),
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]),
                        _taskController.taskList[index],
                      );
                    }
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                              child: TaskTile(
                                  _taskController.taskList[index],
                                  () => _taskController
                                      .delete(_taskController.taskList[index]),
                                  () => _taskController.getTasks())),
                        ));
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
