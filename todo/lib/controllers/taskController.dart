import 'package:get/get.dart';
import 'package:todo/database/databaseHelper.dart';
import 'package:todo/models/taks.dart';

class taskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;
  var searchResults = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await databaseHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await databaseHelper.querry();
    taskList.assignAll((tasks.map((task) => Task.fromJson(task))).toList());
  }

  void delete(Task task) {
    databaseHelper.delete(task);
  }

  void search(String keyword) async {
    List<Map<String, dynamic>> res = await databaseHelper.search(keyword);
    searchResults.assignAll((res.map((task) => Task.fromJson(task))).toList());
  }
}
