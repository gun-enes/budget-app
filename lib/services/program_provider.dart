import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:sql_project2/services/models/daily_data_model.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import 'package:sql_project2/services/models/portfolio_datamodel.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import 'models/income_data_model.dart';
import 'isar_services.dart';
import 'models/monthly_data_model.dart';

class ProgramProvider extends ChangeNotifier {
  final List<IncomeDataModel> _incomeList = [];
  List<IncomeDataModel> get incomeList => _incomeList;
  final List<ExpenseDataModel> _expenseList = [];
  List<ExpenseDataModel> get expenseList => _expenseList;
  final List<DailyDataModel> _dailyList = [];
  List<DailyDataModel> get dailyList => _dailyList;
  final List<MonthlyDataModel> _monthlyList = [];
  List<MonthlyDataModel> get monthlyList => _monthlyList;
  final List<StockDataModel> _stockList = [];
  List<StockDataModel> get stockList => _stockList;
  final List<StockDataModel> _portfolio = [];
  List<StockDataModel> get portfolio => _portfolio;
  final List<String> _hisseisimleri = [];
  List<String> get hisseisimleri => _hisseisimleri;
  final List<String> _hissekodlari = [];
  List<String> get hissekodlari => _hissekodlari;
  final List<String> _hissedegisim = [];
  List<String> get hissedegisim => _hissedegisim;
  final List<String> _hissefiyati = [];
  List<String> get hissefiyati => _hissefiyati;
  final List<PortfolioDataModel> _portfolioList = [];
  List<PortfolioDataModel> get portfolioList => _portfolioList;
  final List<ExpenseDataModel> _expenseCategories = [];
  List<ExpenseDataModel> get expenseCategories => _expenseCategories;
/*
  double _portfolioValue = 0;
  double get portfolioValue => _portfolioValue;
  double _portfolioProfit = 0;
  double get portfolioProfit => _portfolioProfit;*/

  int _limit = 200;
  int get limit => _limit;
  void setLimit(int newValue){
    _limit = newValue;
    notifyListeners();
  }

  Future getData() async {
    _hissekodlari.clear();
    _hisseisimleri.clear();
    _hissefiyati.clear();
    _hissedegisim.clear();
    final url = Uri.parse('https://bigpara.hurriyet.com.tr/doviz/dolar/');
    final url1 = Uri.parse('https://www.oyakyatirim.com.tr/piyasa-verileri/XUTUM');
    final response = await http.get(url);
    final response1 = await http.get(url1);
    dom.Document html = dom.Document.html(response.body);
    dom.Document html1 = dom.Document.html(response1.body);
    final titles = html.querySelectorAll('span.value.up').map((e) => e.innerHtml.trim()).toList();
    final titles1 = html1.querySelectorAll('table > tbody > tr > td').map((e) => e.innerHtml.trim()).toList();
    for(int i = 18; i < titles1.length-3;i = i + 10) {
      if(titles1[i][26] == "\"") {
        _hissekodlari.add(titles1[i].substring(22,26));
      } else {
        _hissekodlari.add(titles1[i].substring(22,27));
      }
      _hisseisimleri.add(titles1[i+1]);
      _hissefiyati.add(titles1[i+2]);
      _hissedegisim.add(titles1[i+6]);
    }
    notifyListeners();
  }
  //HELPERS
  double returnPrice(String name){
    for(int i = 0; i<hissekodlari.length; i++){
      if(hissekodlari[i] == name.toUpperCase()){
        String replaced = hissefiyati[i].replaceAll(',', '.');
        return double.parse(replaced);
      }
    }
    return 0;
  }
  bool returnName(String name){
    for(int i = 0; i<hissekodlari.length; i++){
      if(hissekodlari[i] == name.toUpperCase()){
        return true;
      }
    }
    return false;
  }
  double returnValue(){
    double total = 0;
    for(final para in portfolio){
      if(para.portfolio.toUpperCase() != "BABAM")
        total += returnPrice(para.title)*para.amount;
    }
    return total;
  }
  double returnProfit(){
    double total = 0;
    for(final para in portfolio){
      if(para.portfolio.toUpperCase() != "BABAM")
        total += returnPrice(para.title)*para.amount-para.amount*para.price;
    }
    return total;
  }
  bool returnPortfolioName(String name){
    for(int i = 0; i<portfolioList.length; i++){
      if(portfolioList[i].title.toUpperCase() == name.toUpperCase()){
        return true;
      }
    }
    return false;
  }
  double returnPortfolioValue(String name){
    double total = 0;
    for(final para in portfolio){
      if(para.portfolio.toUpperCase() == name.toUpperCase()) {
        total += returnPrice(para.title)*para.amount;
      }
    }
    return total;
  }
  double returnPortfolioProfit(String name){
    double total = 0;
    for(final para in portfolio){
      if(para.portfolio.toUpperCase() == name.toUpperCase()) {
        total += returnPrice(para.title)*para.amount-para.amount*para.price;
      }
    }
    return total;
  }
  //STOCKS
  void addToStockList(StockDataModel newData){
    /*for(int i = 0; i<_stockList.length; i++){
      if(stockList[i].title == newData.title){
        stockList[i].price
        IsarService().updateStock(stockList[i], newData);
        return;
      }
    }*/
    stockList.add(newData);
    IsarService().addStock(newData);
    notifyListeners();
  }
  void deleteFromStockList(StockDataModel newData){
    stockList.remove(newData);
    IsarService().deleteStock(newData.id);
    notifyListeners();
  }
  void changeStockList(List<StockDataModel> incomes){
    _stockList.clear();
    _stockList.addAll(incomes);
    notifyListeners();
  }
  //INCOME
  void updateIncome(int amount, String title, IncomeDataModel data){
    data.amount = amount;
    data.title = title;
    notifyListeners();
  }
  void addToIncomeList(IncomeDataModel newData){
    IsarService().addIncome(newData);
    _incomeList.add(newData);
    notifyListeners();
  }
  void deleteIncome(IncomeDataModel data){
    IsarService().deleteIncome(data.id);
    _incomeList.remove(data);
    notifyListeners();
  }
  void changeIncomeList(List<IncomeDataModel> incomes){
    _incomeList.clear();
    _incomeList.addAll(incomes);
    notifyListeners();
  }
  //EXPENSES
  void addToExpenseList(ExpenseDataModel newData){
    IsarService().addExpense(newData);
    _expenseList.add(newData);
    notifyListeners();
  }
  void updateExpense(ExpenseDataModel newData, ExpenseDataModel oldData){
    deleteExpense(oldData);
    addToExpenseList(newData);
  }
  void deleteExpense(ExpenseDataModel data){
    IsarService().deleteExpense(data.id);
    _expenseList.remove(data);
    notifyListeners();
  }
  void changeExpenseList(List<ExpenseDataModel> expenses){
    _expenseList.clear();
    _expenseList.addAll(expenses);
    notifyListeners();
  }



  List<ExpenseDataModel> getExpenseByKind(List<ExpenseDataModel> exp) {
    bool control = true;
    List<ExpenseDataModel> expCat = [];
    List<ExpenseDataModel> _tempExpenseCat = [];
    for(int i = 0; i < exp.length; i++){
      for(int j = 0; j< _tempExpenseCat.length; j++){
        if(exp[i].title == _tempExpenseCat[j].title){
          _tempExpenseCat[j].amount += exp[i].amount;
          control = false;
          break;
        }
      }
      if(control) {
        _tempExpenseCat.add(ExpenseDataModel()
          ..title = exp[i].title
          ..amount = exp[i].amount
          ..type = exp[i].type
          ..date = exp[i].date
        );
      }
      control = true;
    }
    for(; _tempExpenseCat.length>0;){
      ExpenseDataModel temp;
      temp = _tempExpenseCat[0];
      for(int j = 0; j < _tempExpenseCat.length;j++){
        if(_tempExpenseCat[j].amount>temp.amount){
          temp = _tempExpenseCat[j];
        }
      }
      print(temp);
      expCat.add(temp);
      _tempExpenseCat.remove(temp);
    }
    return expCat;
  }

  List<ExpenseDataModel> getExpenseByMonth(List<ExpenseDataModel> exp, DateTime date) {
    List<ExpenseDataModel> items = exp.where((item) {
      return item.date.year == date.year && item.date.month == date.month;
    }).toList();
    return items;
  }
  //DAILY
  void addToDailyList(DailyDataModel newData){
    IsarService().addDaily(newData);
    _dailyList.add(newData);
    notifyListeners();
  }
  void deleteDay(DailyDataModel data){
    if(data.date.day == 1){
      deleteMonth(_monthlyList.last);
    }
    IsarService().deleteDaily(data.id);
    _dailyList.remove(data);
    notifyListeners();
  }
  void changeDailyList(List<DailyDataModel> daily){
    _dailyList.clear();
    _dailyList.addAll(daily);
    notifyListeners();
  }
  //MONTHLY
  void addToMonthlyList(MonthlyDataModel newData){
    IsarService().addMonthly(newData);
    _monthlyList.add(newData);
    notifyListeners();
  }
/*
  void update(){
    for(int i = 0; i < _incomeList.length; i++) {
      ExpenseDataModel k = ExpenseDataModel()
        ..amount = _incomeList[i].amount
        ..date = _incomeList[i].date
        ..title = _incomeList[i].title
        ..type = "Income";
      addToExpenseList(k);
    }
  }
*/

  void deleteMonth(MonthlyDataModel data){
    IsarService().deleteMonthly(data.id);
    _monthlyList.remove(data);
    notifyListeners();
  }
  void changeMonthlyList(List<MonthlyDataModel> monthly){
    _monthlyList.clear();
    _monthlyList.addAll(monthly);
    notifyListeners();
  }
  //PORTFOLIO
  void addToPortfolioList(PortfolioDataModel newData){
    IsarService().addPortfolio(newData);
    _portfolioList.add(newData);
    notifyListeners();
  }
  void deletePortfolioList(PortfolioDataModel newData){
    IsarService().deletePortfolio(newData.id);
    _portfolioList.remove(newData);
    notifyListeners();
  }
  void changePortfolioList(List<PortfolioDataModel> portfolios) {
    _portfolioList.clear();
    _portfolioList.addAll(portfolios);
    notifyListeners();
  }
  void clearPortfolio(){
    _portfolio.clear();
    notifyListeners();
  }
  void createPortfolio(){
    _portfolio.clear();
    bool control = true;
    for(int i = 0; i < _stockList.length; i++){
      for(int j = 0; j< _portfolio.length; j++){
        if(_stockList[i].title == _portfolio[j].title && _stockList[i].portfolio == _portfolio[j].portfolio){
          if(_stockList[i].amount>0) {
            _portfolio[j].price = (_portfolio[j].amount*_portfolio[j].price + _stockList[i].amount*_stockList[i].price)/(_portfolio[j].amount + _stockList[i].amount);
          }
          _portfolio[j].amount += _stockList[i].amount;
          if(_portfolio[j].amount == 0){
            _portfolio.remove(_portfolio[j]);
          }
          control = false;
          break;
        }
      }
      if(control) {
        _portfolio.add(StockDataModel()
          ..price = _stockList[i].price
          ..title = _stockList[i].title
          ..amount = _stockList[i].amount
          ..portfolio = _stockList[i].portfolio
          ..date = _stockList[i].date
        );
      }
      control = true;
    }
    notifyListeners();
  }
  double returnCost(String stockName){
    for(final item in _stockList){
      if(item.title.toUpperCase() == stockName.toUpperCase()){
        return item.price;
      }
    }
    return 0;
  }
  int returnStockInPortfolio(String portfolioName, String stockName){

    List<StockDataModel> items = _portfolio.where((item) {
      return item.portfolio.toUpperCase() == portfolioName.toUpperCase() && item.title.toUpperCase() == stockName.toUpperCase();
    }).toList();
    return items.length == 0 ? 0:items[0].amount;
  }
  List<StockDataModel> getStocksByPortfolio(String name) {
    List<StockDataModel> items = _portfolio.where((item) {
      return item.portfolio.toUpperCase() == name.toUpperCase();
    }).toList();
    return items;
  }





  void deleteall(){
    int a = sum_outcome()-sum_days();
    if(dailyList.isNotEmpty){
      DateTime x = _dailyList.last.date;
      if((x.month == 1 || x.month == 3 || x.month == 5 || x.month == 7 || x.month == 8 || x.month == 10 || x.month == 12) && x.day == 31){
        final dataLocal = MonthlyDataModel()
          ..title = x
          ..expense = sum_outcome_prev()
          ..income = sum_income_prev();
        addToMonthlyList(dataLocal);
      }
      if((x.month == 4 || x.month == 6 || x.month == 9 || x.month == 11) && x.day == 30){
        final dataLocal = MonthlyDataModel()
          ..title = x
          ..expense = sum_outcome_prev()
          ..income = sum_income_prev();
        addToMonthlyList(dataLocal);
      }
      if(x.month == 2 && x.day == 28 && x.year%4 != 0){
        final dataLocal = MonthlyDataModel()
          ..title = x
          ..expense = sum_outcome_prev()
          ..income = sum_income_prev();
        addToMonthlyList(dataLocal);
      }
      if(x.month == 2 && x.day == 29){
        final dataLocal = MonthlyDataModel()
          ..title = x
          ..expense = sum_outcome_prev()
          ..income = sum_income_prev();
        addToMonthlyList(dataLocal);
      }
      final dataLocal = DailyDataModel()
        ..limit = limit
        ..amount = a
        ..date = _dailyList.last.date.add(const Duration(days: 1));
      addToDailyList(dataLocal);
    }
    else{
      final dataLocal = DailyDataModel()
        ..limit = limit
        ..amount = a
        ..date = _expenseList.last.date;
      addToDailyList(dataLocal);
    }
    notifyListeners();
  }
  int sum_income_prev(){
    int toplam = 0;
    DateTime x = _expenseList.last.date;
    for(final para in _expenseList){
      if(para.type == "Income") {
        if (para.date.month == x.month && para.date.year == x.year) {
          toplam += para.amount;
        }
      }
    }
    return toplam;
  }
  int sum_outcome_prev(){
    int toplam = 0;
    DateTime x = _dailyList.last.date;
    for(final para in _dailyList){
      if(para.date.month == x.month && para.date.year == x.year) {
        toplam += para.limit;
      }
    }
    return toplam;
  }
  int incomeCurrentMonth(){
    int toplam = 0;
    for(final para in _expenseList){
      if(para.type == "Income")
      if(para.date.month == DateTime.now().month) {
        toplam += para.amount;
      }
    }
    return toplam;
  }
  int expenseCurrentMonth(){
    int toplam = 0;
    for(final para in _expenseList){
      if(para.type == "Expense")
        if(para.date.month == DateTime.now().month) {
        toplam += para.amount;
      }
    }
    return toplam;
  }
  int limit_outcome(){
    int toplam = 0;
    for(final para in _dailyList){
      toplam += para.limit;
    }
    return toplam;
  }
  int sum_days(){
    int toplam = 0;
    for(final para in _dailyList){
      toplam += para.amount;
    }
    return toplam;
  }
  int sum_income(){
    int toplam = 0;
    for(final para in _expenseList){
      if(para.type == "Income") {
        toplam += para.amount;
      }
    }
    return toplam;
  }
  int sum_outcome(){
    int toplam = 0;
    for(final para in _expenseList){
      if(para.type == "Expense") {
        toplam += para.amount;
      }
    }
    return toplam;
  }
  Widget iconExpense(ExpenseDataModel data){
    if(data.title == "Fatura") {
      return const Icon(Icons.insert_chart, color: Colors.white,);
    }if(data.title == "Alkol") {
      return const Icon(Icons.wine_bar, color: Colors.white,);
    }if(data.title == "Sigara") {
      return const Icon(Icons.smoking_rooms, color: Colors.white,);
    }if(data.title == "Market"){
      return const Icon(Icons.local_mall, color: Colors.white,);
    }if(data.title == "Yemek"){
      return const Icon(Icons.dinner_dining, color: Colors.white,);
    }if(data.title == "Cafe"){
      return const Icon(Icons.local_cafe, color: Colors.white,);
    }if(data.title == "Para Çekme"){
      return const Icon(Icons.money,color: Colors.white);
    }if(data.title == "Borç"){
      return const Icon(Icons.money_off_csred_sharp,color: Colors.white);
    }if(data.title == "Su"){
      return const Icon(Icons.water_drop_rounded,color: Colors.white);
    }if(data.title == "Ulaşım"){
      return const Icon(Icons.emoji_transportation,color: Colors.white);
    }if(data.title == "Taksitler"){
      return const Icon(Icons.money,color: Colors.white);
    }if(data.title == "Alışveriş"){
      return const Icon(Icons.shopping_bag_sharp,color: Colors.white);
    }if(data.title == "Maaş") {
      return const Icon(Icons.attach_money_rounded, color: Colors.white,);
    }if(data.title == "Baba"){
      return const Icon(Icons.man_sharp, color: Colors.white,);
    }if(data.title == "Cashback"){
      return const Icon(Icons.money_off_csred_sharp, color: Colors.white,);
    }if(data.title == "Borç"){
      return const Icon(Icons.add_reaction_outlined, color: Colors.white,);
    }if(data.title == "Borsa"){
      return const Icon(Icons.add_business, color: Colors.white,);
    }if(data.title == "Burs"){
      return const Icon(Icons.add_chart, color: Colors.white,);
    }
    return const Icon(Icons.attach_money,color: Colors.white);
  }


}

