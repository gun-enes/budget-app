import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/navbars/bottom_nav_bar.dart';
import 'package:sql_project2/services/isar_services.dart';
import 'package:sql_project2/services/models/daily_data_model.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import 'package:sql_project2/services/models/income_data_model.dart';
import 'package:sql_project2/services/models/monthly_data_model.dart';
import 'package:sql_project2/services/models/portfolio_datamodel.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import 'services/program_provider.dart';


void main() async {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => ProgramProvider())
      ], child: MyApp()));

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> getNecessaryData(context) async {
    var programProvider = Provider.of<ProgramProvider>(context, listen: false);
    try {
      Isar db = await IsarService.openDB();
      List<IncomeDataModel> incomeList = await IsarService.getAllIncome(db);
      List<ExpenseDataModel> expenseList = await IsarService.getAllExpense(db);
      List<DailyDataModel> dailyList = await IsarService.getAllDaily(db);
      List<MonthlyDataModel> monthlyList = await IsarService.getAllMonthly(db);
      List<StockDataModel> stockList = await IsarService.getAllStocks(db);
      List<PortfolioDataModel> portfolioList = await IsarService.getAllPortfolios(db);
      programProvider.changeExpenseList(expenseList);
      programProvider.changeIncomeList(incomeList);
      programProvider.changeDailyList(dailyList);
      programProvider.changeMonthlyList(monthlyList);
      programProvider.changeStockList(stockList);
      programProvider.changePortfolioList(portfolioList);
      programProvider.getData();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        cardColor: Colors.white,
        useMaterial3: true
      ),
      darkTheme: ThemeData.dark().copyWith(
        cardColor: Colors.grey[800],
        useMaterial3: true,
        canvasColor: Colors.grey[800]
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
          future: getNecessaryData(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return const NavigasyonBar();
              } else {
                return const Center(child: Text("Error"));
              }
            }
            return Container();
          }),
    );
  }
}
