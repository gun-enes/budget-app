import 'package:flutter/material.dart';
import 'package:sql_project2/pages/hisseler.dart';
import 'package:sql_project2/pages/portfolios/all_portfolios.dart';
import 'package:sql_project2/pages/portfolios/portfolio.dart';

class StockTopNav extends StatelessWidget {
  const StockTopNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
          backgroundColor: Colors.blue,
          //foregroundColor: Colors.black,

          title: TabBar(
            dividerColor: Colors.transparent,
            indicatorWeight: 2,
            indicatorColor: Colors.blue[50],
            tabs:  const [
              Tab(child: Text("Portföyler", style: TextStyle(color: Colors.white),)),
              Tab(child: Text("BIST100 Hisseleri", style: TextStyle(color: Colors.white),)),
            ],
          ),
          //title: Text('AKIŞ'),
        ),
        body: const TabBarView(
          children:  [
            AllPortfolios(),
            Hisseler(),

          ],
        ),
      ),
    );
  }
}
