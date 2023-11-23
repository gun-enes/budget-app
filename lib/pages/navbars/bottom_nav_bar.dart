import 'package:flutter/material.dart';
import 'package:sql_project2/pages/expenses/expenses.dart';
import 'package:sql_project2/pages/portfolio_list/all_portfolios.dart';
import '../alltime/alltime.dart';

class NavigasyonBar extends StatefulWidget {
  const NavigasyonBar({Key? key}) : super(key: key);

  @override
  State<NavigasyonBar> createState() => _NavigasyonBarState();
}

class _NavigasyonBarState extends State<NavigasyonBar> {
  PageController _pageController = PageController();
  List<Widget> pages = [
    const AllPortfolios(),
    const AllTime(),
    const Expenses(),
  ];
  int currentIndex = 1;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          _pageController.jumpToPage(index);/*
          _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 150),
          curve: Curves.bounceIn,);*/
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        backgroundColor: Colors.amber,
        type: BottomNavigationBarType.shifting,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Yatırım"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "AnaSayfa"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: "Gelir-Gider",
          ),
        ],
      ),
    );
  }
}