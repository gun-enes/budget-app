import 'package:flutter/material.dart';
import 'package:sql_project2/services/models/daily_data_model.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
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

  int _limit = 200;
  int get limit => _limit;
  void setLimit(int newValue){
    _limit = newValue;
    notifyListeners();
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          behavior: SnackBarBehavior.floating,
          elevation: 5,
          backgroundColor: Colors.white,
          content: Text(text,style: TextStyle(color: Colors.blue),),
          duration: const Duration(seconds: 4),
          animation: CurvedAnimation(
            parent: const AlwaysStoppedAnimation<double>(1),
            curve: Curves.fastOutSlowIn,
          ),
      ),
    );
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
  /*int incomeListTotal(){
    int alim = 0;
    int satim = 0;
    for(final item in _incomeList){
      if(item.title == "Hisse alım"){
        alim += item.amount;
      }
      if(item.title == "Hisse satım"){
        satim += item.amount;
      }
    }
  }*/
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
      expCat.add(temp);
      _tempExpenseCat.remove(temp);
    }/*
    int a = 0,b = 0;
    for(final item in expCat){
      if(item.title == "Hisse alım"){
        a = item.amount;
        //expCat.remove(item);
      }
      if(item.title == "Hisse satım"){
        b = item.amount;
        //expCat.remove(item);
      }
    }
    expCat.removeWhere((element) => element.title == "Hisse alım" || element.title == "Hisse satım");
    if(a != 0 && a - b > 0){
      expCat.add(ExpenseDataModel()..amount = b - a..title = "Hisse zararı"..date = DateTime.now()..type = "Expense");

    }
    else if(a != 0 && a - b < 0){
      expCat.add(ExpenseDataModel()..amount = b - a..title = "Hisse karı"..date = DateTime.now()..type = "Income");
    }*/
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
    if(data.date.day == 1 && _monthlyList.isNotEmpty){
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
        ..date = _dailyList.isEmpty ? _expenseList.isEmpty ? DateTime.now(): _expenseList.last.date: _dailyList.last.date.add(const Duration(days: 1));
      addToDailyList(dataLocal);
    }
    else{
      final dataLocal = DailyDataModel()
        ..limit = limit
        ..amount = a
        ..date = _expenseList.isEmpty ? DateTime.now():_expenseList.last.date;
      addToDailyList(dataLocal);
    }
    notifyListeners();
  }
  int sum_income_prev(){
    int toplam = 0;
    DateTime x = _expenseList.isEmpty ? DateTime.now():_expenseList.last.date;
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
      if(para.type == "Income") {
        if (para.date.month == DateTime.now().month) {
          toplam += para.amount;
        }
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

