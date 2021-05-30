import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_mind/screens/articles.dart';
import 'package:healthy_mind/screens/chatbot.dart';
import 'package:healthy_mind/screens/home.dart';
import 'package:healthy_mind/screens/therapists.dart';

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 12),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [Home(), Therapists(), Articles(),HomePageDialogflow()],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        border: Border(
            top: BorderSide(
                style: BorderStyle.solid,
                color: Theme.of(context).primaryColor)),
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.healing_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.article)),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble)),
        ],
      ),
    );
  }
}
