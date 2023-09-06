import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/expenses/expenses.dart';
import 'package:sql_project2/pages/navbars/topnav%20hisseler.dart';
import 'package:sql_project2/pages/navbars/topnav.dart';
import 'package:sql_project2/pages/portfolios/all_portfolios.dart';
import 'package:sql_project2/services/program_provider.dart';
import '../alltime/alltime.dart';
import '../month/months.dart';

class NavigasyonBar extends StatefulWidget {
  const NavigasyonBar({Key? key}) : super(key: key);

  @override
  State<NavigasyonBar> createState() => _NavigasyonBarState();
}

class _NavigasyonBarState extends State<NavigasyonBar> {
  PageController _pageController = PageController();
  List<Widget> pages = [
    const AllTime(),
    const Expenses(),
    const AllPortfolios()
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
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
          if(index == 2){
            programProvider.createPortfolio();
          }
          _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 150),
          curve: Curves.ease,);
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        backgroundColor: Colors.amber,
        type: BottomNavigationBarType.shifting,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "AnaSayfa"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: "Gelir-Gider",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Yatırım"
          ),
        ],
      ),

    );
  }
}
