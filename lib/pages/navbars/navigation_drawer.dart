import 'package:flutter/material.dart';
import 'package:sql_project2/pages/alltime/alltime.dart';
import 'package:sql_project2/pages/portfolio_list/all_portfolios.dart';

import '../expenses/expenses.dart';

class NavDraw extends StatefulWidget {
  const NavDraw({Key? key}) : super(key: key);

  @override
  State<NavDraw> createState() => _NavDrawState();
}

class _NavDrawState extends State<NavDraw> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text("Gün Sonu",style: TextStyle(fontSize: 18),),
              leading: const Icon(Icons.calendar_today),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AllTime()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text("Gelir/Gider",style: TextStyle(fontSize: 18)),
              leading: const Icon(Icons.attach_money),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Expenses()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text("Yatırım",style: TextStyle(fontSize: 18)),
              leading: const Icon(Icons.add_chart),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPortfolios()));
              },
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[500],
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text("Ayarlar",style: TextStyle(fontSize: 18)),
              leading: const Icon(Icons.settings),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPortfolios()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
