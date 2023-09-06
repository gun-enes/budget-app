import 'package:flutter/material.dart';
import 'package:sql_project2/pages/expenses/expenses.dart';
import 'package:sql_project2/pages/stock_add/stocks.dart';
import 'package:sql_project2/pages/income/incomes.dart';

class TopNav extends StatelessWidget {
  const TopNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.blue,
          //foregroundColor: Colors.black,

          title: TabBar(
            dividerColor: Colors.transparent,
            indicatorWeight: 2,
            indicatorColor: Colors.blue[50],
            tabs:  const [
              Tab(child: Text("Giderler", style: TextStyle(color: Colors.white),)),
              Tab(child: Text("Gelirler", style: TextStyle(color: Colors.white),)),
            ],
          ),
          //title: Text('AKIŞ'),
        ),
        body: const TabBarView(
          children:  [
            Expenses(),
            Incomes(),
          ],
        ),
      ),
    );
  }
}
