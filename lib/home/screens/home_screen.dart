import 'package:flutter/material.dart';
import 'package:todo/home/screens/completed_screen.dart';
import 'package:todo/home/screens/profiled_screen.dart';
import 'package:todo/home/screens/task_screen.dart';
import 'package:todo/utils/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;
  List<Widget> screens = [
    const TaskScreen(),
    const CompletedScreen(),
    const ProfiledScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        title: Text(
          "To-Doze",
          style: AppTheme.titleText.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 30),
        child: SafeArea(
          child: screens[_selectedindex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey, //New
                blurRadius: 25.0,
                offset: Offset(0, 5))
          ],
        ),
        height: 70,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: BottomNavigationBar(
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            iconSize: 20.0,
            selectedIconTheme: const IconThemeData(size: 28.0),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            selectedFontSize: 16.0,
            unselectedFontSize: 12,
            onTap: (i) {
              setState(() {
                _selectedindex = i;
              });
            },
            currentIndex: _selectedindex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded),
                label: "Tasks",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.done_outline_outlined),
                label: "Completed",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
