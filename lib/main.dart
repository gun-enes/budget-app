import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/alltime/alltime.dart';
import 'package:sql_project2/pages/navbars/bottom_nav_bar.dart';
import 'package:sql_project2/services/invest_provider.dart';
import 'package:sql_project2/services/isar_services.dart';
import 'package:sql_project2/services/models/cash.dart';
import 'package:sql_project2/services/models/daily_data_model.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import 'package:sql_project2/services/models/income_data_model.dart';
import 'package:sql_project2/services/models/monthly_data_model.dart';
import 'package:sql_project2/services/models/portfolio_datamodel.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import 'package:sql_project2/services/models/watchlist.dart';
import 'package:sql_project2/services/notifications.dart';
import 'package:sql_project2/services/prediction_provider.dart';
import 'services/program_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  Noti.initialize(flutterLocalNotificationsPlugin);
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => ProgramProvider()),
        ChangeNotifierProvider(create: (_) => InvestProvider()),
        ChangeNotifierProvider(create: (_) => PredictionProvider()),
      ], child: MyApp()));

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> getNecessaryData(context) async {
    var programProvider = Provider.of<ProgramProvider>(context, listen: false);
    var investProvider = Provider.of<InvestProvider>(context, listen: false);
    try {
      Isar db = await IsarService.openDB();
      List<IncomeDataModel> incomeList = await IsarService.getAllIncome(db);
      List<ExpenseDataModel> expenseList = await IsarService.getAllExpense(db);
      List<DailyDataModel> dailyList = await IsarService.getAllDaily(db);
      List<MonthlyDataModel> monthlyList = await IsarService.getAllMonthly(db);
      List<StockDataModel> stockList = await IsarService.getAllStocks(db);
      List<PortfolioDataModel> portfolioList = await IsarService.getAllPortfolios(db);
      List<WatchListDataModel> watchList = await IsarService.getAllWatchList(db);
      List<CashDataModel> cashList = await IsarService.getAllCash(db);
      investProvider.changeCashList(cashList);
      investProvider.changeWatchList(watchList);
      programProvider.changeExpenseList(expenseList);
      programProvider.changeIncomeList(incomeList);
      programProvider.changeDailyList(dailyList);
      programProvider.changeMonthlyList(monthlyList);
      investProvider.changeStockList(stockList);
      investProvider.changePortfolioList(portfolioList);
      investProvider.getData();
      investProvider.getBIST();
      investProvider.getDollar();
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
        //cardColor: Colors.white,
        useMaterial3: true
      ),
      darkTheme: ThemeData.dark().copyWith(
        //cardColor: Colors.grey[800],
        useMaterial3: true,
        //canvasColor: Colors.grey[800]
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
