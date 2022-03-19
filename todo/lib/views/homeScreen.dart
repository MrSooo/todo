import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/controllers/taskController.dart';
import 'package:todo/services/themeService.dart';
import 'package:todo/views/pages/addTodoPage.dart';
import 'package:todo/views/pages/allPage.dart';
import 'package:todo/views/pages/todayPage.dart';
import 'package:todo/views/pages/upcomingPage.dart';
import 'package:todo/views/theme.dart';

import '../services/notifyService.dart';
import '../widgets/taskCard.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final _taskController = Get.put(taskController());
  bool _isDarkMode = false;
  int _currentIndex = 0;
  final appbarTitles = [
    'All',
    'Today',
    'Upcoming',
  ];
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
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        title: Text(
          'Todo List',
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,
                color: Get.isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(
                _isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                color: Get.isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
              themeService().switchTheme();
              // notifyHelper.displayNotification(
              //     title: 'Theme changed',
              //     body: Get.isDarkMode
              //         ? 'Light Mode Activated'
              //         : 'Dark Mode Activated');

              // notifyHelper.scheduledNotification();
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          allPage(),
          todayPage(),
          upcomingPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.red[300],
        onPressed: () async {
          await Get.to(() => addTodoPage());
          _taskController.getTasks();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          showUnselectedLabels: false,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              label: appbarTitles[_currentIndex],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: appbarTitles[_currentIndex],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: appbarTitles[_currentIndex],
            ),
          ]),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final _taskController = Get.put(taskController());
  List<String> searchResults = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isNotEmpty) {
              query = '';
            } else {
              close(context, null);
            }
          },
        ),
      ];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        },
      );
  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      _taskController.search(query);
      searchResults.insert(0, query);
      searchResults.removeLast();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Search results for '$query'",
          style: headingTextStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Center(
            child: Obx(
              () => ListView.builder(
                  itemCount: _taskController.searchResults.length,
                  itemBuilder: (_, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                              child: TaskTile(
                                  _taskController.searchResults[index],
                                  () => _taskController.delete(
                                      _taskController.searchResults[index]),
                                  () => _taskController.getTasks())),
                        ));
                  }),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
