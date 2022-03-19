import 'package:flutter/material.dart';
import 'package:get/get.dart';

class notificationPage extends StatelessWidget {
  final String? payload;
  const notificationPage({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text("Todo task",
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Get.isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
          child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(int.parse(payload.toString().split("|")[4])),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task title: " + payload.toString().split("|")[0],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Description: " + payload.toString().split("|")[1],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 7),
                  Text(
                    payload.toString().split("|")[2],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 7),
                  Text(
                    payload.toString().split("|")[3],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
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
