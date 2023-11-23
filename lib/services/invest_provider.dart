import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'isar_services.dart';
import 'models/cash.dart';
import 'models/expense_data_model.dart';
import 'models/portfolio_datamodel.dart';
import 'models/stock_datamodel.dart';
import 'models/watchlist.dart';

class InvestProvider extends ChangeNotifier {
  bool controller = false;
  int stockCount = 0;
  bool isCheckedForPrice = true;
  bool isCheckedForDollar = true;

  String _bist = "-";
  String get bist => _bist;

  String _dollar = "-";
  String get dollar => _dollar;

  final List<WatchListDataModel> _adviceList = [];
  List<WatchListDataModel> get adviceList => _adviceList;

  final List<CashDataModel> _cashList = [];
  List<CashDataModel> get cashList => _cashList;

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
  final List<String> _hisseFK = [];

  List<String> get hisseFK => _hisseFK;
  final List<String> _hissePDDD = [];

  List<String> get hissePDDD => _hissePDDD;

  final List<PortfolioDataModel> _portfolioList = [];

  List<PortfolioDataModel> get portfolioList => _portfolioList;

  final List<ExpenseDataModel> _expenseCategories = [];

  List<ExpenseDataModel> get expenseCategories => _expenseCategories;

  final List<WatchListDataModel> _watchList = [];

  List<WatchListDataModel> get watchList => _watchList;

  List<String> get portfolioNames {
    List<String> portfolioNames = [];
    for (int i = 0; i < _portfolioList.length; i++) {
      portfolioNames.add(_portfolioList[i].title);
    }
    return portfolioNames;
  }

  //HELPERS
  double returnChange(String name) {
    for (int i = 0; i < hissekodlari.length; i++) {
      if (hissekodlari[i] == name.toUpperCase()) {
        String replaced = hissedegisim[i].replaceAll(',', '.');
        return double.parse(replaced);
      }
    }
    return 0;
  }

  double returnPrice(String name) {
    for (int i = 0; i < hissekodlari.length; i++) {
      if (hissekodlari[i] == name.toUpperCase()) {
        String replaced = hissefiyati[i].replaceAll(',', '.');
        return double.parse(replaced);
      }
    }
    return 0;
  }

  bool returnName(String name) {
    for (int i = 0; i < hissekodlari.length; i++) {
      if (hissekodlari[i] == name.toUpperCase()) {
        return true;
      }
    }
    return false;
  }

  double returnValue() {
    double total = 0;
    for (final para in portfolio) {
      if (para.portfolio.toUpperCase() != "BABAM") {
        total += returnPrice(para.title) * para.amount;
      }
    }
    return total;
  }

  double returnProfit() {
    double total = 0;
    for (final para in portfolio) {
      if (para.portfolio.toUpperCase() != "BABAM") {
        total +=
            returnPrice(para.title) * para.amount - para.amount * para.price;
      }
    }
    return total;
  }

  bool returnPortfolioName(String name) {
    for (int i = 0; i < portfolioList.length; i++) {
      if (portfolioList[i].title.toUpperCase() == name.toUpperCase()) {
        return true;
      }
    }
    return false;
  }

  double returnPortfolioValue(String name) {
    double total = 0;
    for (final para in portfolio) {
      if (para.portfolio.toUpperCase() == name.toUpperCase()) {
        total += returnPrice(para.title) * para.amount;
      }
    }
    return total;
  }

  double returnPortfolioProfit(String name) {
    double total = 0;
    for (final para in portfolio) {
      if (para.portfolio.toUpperCase() == name.toUpperCase()) {
        total +=
            returnPrice(para.title) * para.amount - para.amount * para.price;
      }
    }
    return total;
  }
  double returnPortfolioValueDollar(String name) {
    double total = 0;
    for (final para in portfolio) {
      if (para.portfolio.toUpperCase() == name.toUpperCase()) {
        total += (returnPrice(para.title) * para.amount)/double.parse(dollar);
      }
    }
    return total;
  }

  double returnPortfolioProfitDollar(String name) {
    double total = 0;
    for (final para in portfolio) {
      if (para.portfolio.toUpperCase() == name.toUpperCase()) {
        print(para.dollar);
        total +=
            (returnPrice(para.title) * para.amount)/double.parse(dollar) - (para.amount * para.price)/para.dollar;
      }
    }
    return total;
  }
  double returnPortfolioValueBist(String name) {
    double total = 0;
    for (final para in portfolio) {
      if (para.portfolio.toUpperCase() == name.toUpperCase()) {
        total += (returnPrice(para.title) * para.amount)/double.parse(bist);
      }
    }
    return total;
  }

  double returnPortfolioProfitBist(String name) {
    double total = 0;
    for (final para in portfolio) {
      if (para.portfolio.toUpperCase() == name.toUpperCase()) {
        total += (returnPrice(para.title) * para.amount)/double.parse(bist) - (para.amount * para.price)/para.bist;
      }
    }
    return total;
  }


  //WEB SCRAPING
  Future getData() async {
    final url1 = Uri.parse(
        'https://www.oyakyatirim.com.tr/piyasa-verileri/XUTUM');
    final response1 = await http.get(url1);
    dom.Document html1 = dom.Document.html(response1.body);
    final titles1 = html1.querySelectorAll('table > tbody > tr > td').map((e) =>
        e.innerHtml.trim()).toList();
    _hissekodlari.clear();
    _hisseisimleri.clear();
    _hissefiyati.clear();
    _hissedegisim.clear();
    for (int i = 18; i < titles1.length - 3; i = i + 10) {
      if (titles1[i][26] == "\"") {
        _hissekodlari.add(titles1[i].substring(22, 26));
      }
      else {
        _hissekodlari.add(titles1[i].substring(22, 27));
      }
      _hisseisimleri.add(titles1[i + 1]);
      _hissefiyati.add(titles1[i + 2]);
      _hissedegisim.add(titles1[i + 6]);
    }
    //getRatios();
    createPortfolio();
    notifyListeners();
  }

  Future getDollar() async {
    final url = Uri.parse('https://bigpara.hurriyet.com.tr/doviz/dolar/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      dom.Document html = dom.Document.html(response.body);
      final value = html.querySelectorAll('span.value.up').map((e) =>
          e.innerHtml.trim()).toList();
      _dollar = value.first.toString().replaceAll(',', '.');
    }
    else {
      print("Error");
    }
  }

  Future getBIST() async {
    final url = Uri.parse('https://bigpara.hurriyet.com.tr/borsa/canli-borsa/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      dom.Document html = dom.Document.html(response.body);
      final value = html.querySelectorAll(
          '#content > div > div.contentLeft > div > div.wideContent.sort-bar-x > div.filterBar.liveStockFilterBar > div > div.stockPrice.node-c')
          .map((e) => e.innerHtml.trim())
          .toList();
      _bist = value.first.toString().replaceAll(',', '.');
    }
    else {
      print("Error");
    }
  }

  Future<void> getRatios() async {
    stockCount = 0;
    for (int i = 0; i < _hissekodlari.length; i++) {
      String code = _hissekodlari[i];
      final urlRatios = Uri.parse(
          'https://www.isyatirim.com.tr/tr-tr/analiz/hisse/Sayfalar/sirket-karti.aspx?hisse=$code');
      final responseRatios = await http.get(urlRatios);
      if (responseRatios.statusCode == 200) {
        dom.Document htmlRatios = dom.Document.html(responseRatios.body);
        final ratioElement = htmlRatios.querySelector(
            '#ctl00_ctl58_g_76ae4504_9743_4791_98df_dce2ca95cc0d > div.box-content > div > table > tbody > tr:nth-child(1) > td');
        final ratioElement2 = htmlRatios.querySelector(
            '#ctl00_ctl58_g_76ae4504_9743_4791_98df_dce2ca95cc0d > div.box-content > div > table > tbody > tr:nth-child(5) > td');
        final ratioElement3 = htmlRatios.querySelector(
            '#ctl00_ctl58_g_76ae4504_9743_4791_98df_dce2ca95cc0d > div.box-content > div > table > tbody > tr:nth-child(5) > td');
        final ratioElement4 = htmlRatios.querySelector(
            '#ctl00_ctl58_g_76ae4504_9743_4791_98df_dce2ca95cc0d > div.box-content > div > table > tbody > tr:nth-child(5) > td');
        ratioElement == null ? hisseFK.add("-") : hisseFK.add(
            ratioElement.text);
        ratioElement2 == null ? hissePDDD.add("-") : hissePDDD.add(
            ratioElement2.text);
        stockCount++;
        notifyListeners();
        if(!(hisseFK[i] == "-" || hissePDDD[i] == "-" || hisseFK[i] == "A/D" || hissePDDD[i] == "A/D")){
          if(double.parse(hisseFK[i].replaceAll(',', '.'))*double.parse(hissePDDD[i].replaceAll(',', '.')) < 10){
            adviceList.add(WatchListDataModel()
              ..title = hissekodlari[i]
            );
          }
        }
      } else {
        throw Exception('Failed to load page');
      }

    }controller = true;
    notifyListeners();
  }

  //STOCKS
  void addToStockList(StockDataModel newData) {
    stockList.add(newData);
    IsarService().addStock(newData);
    notifyListeners();
  }

  void deleteFromStockList(StockDataModel newData) {
    stockList.remove(newData);
    IsarService().deleteStock(newData.id);
    notifyListeners();
  }

  void changeStockList(List<StockDataModel> incomes) {
    _stockList.clear();
    _stockList.addAll(incomes);
    notifyListeners();
  }

  List<StockDataModel> getStockHistoryByPortfolio(String name) {
    List<StockDataModel> items = _stockList.where((item) {
      return item.portfolio.toUpperCase() == name.toUpperCase();
    }).toList();
    return items;
  }

  double lengthOfPriceList(double price) {
    if (price < 25) {
      return price * 0.2 * 100;
    }
    if (price < 50) {
      return price * 0.2 * 50;
    }
    if (price < 100) {
      return price * 0.2 * 20;
    }
    if (price < 1000) {
      return price * 0.2 * 10;
    }
    if (price < 5000) {
      return price * 0.2 * 5;
    }
    if (price < 10000) {
      return price * 0.2 * 2;
    }
    return price * 0.2 * 1;
  }

  double partOfPriceList(double price, int index) {
    if (index == (lengthOfPriceList(price) / 2).toInt()) {
      return price;
    }
    if (price < 25) {
      return 0.01 * index + price * 0.9;
    }
    if (price < 50) {
      return 0.02 * index + price * 0.9;
    }
    if (price < 100) {
      return 0.05 * index + price * 0.9;
    }
    if (price < 1000) {
      return 0.1 * index + price * 0.9;
    }
    if (price < 5000) {
      return 0.2 * index + price * 0.9;
    }
    if (price < 10000) {
      return 0.5 * index + price * 0.9;
    }
    return 1 * index + price * 0.9;
  }

  //PORTFOLIO
  void addToPortfolioList(PortfolioDataModel newData) {
    IsarService().addPortfolio(newData);
    _portfolioList.insert(0, newData);
    notifyListeners();
  }

  void deletePortfolioList(PortfolioDataModel newData) {
    IsarService().deletePortfolio(newData.id);
    _portfolioList.remove(newData);
    notifyListeners();
  }

  void updatePortfolioList(PortfolioDataModel oldData,PortfolioDataModel newData) {

    for(int i = 0; i < _stockList.length; i++){
      print(oldData.title);
      if(_stockList[i].portfolio == oldData.title){
        StockDataModel temp = StockDataModel()..title = _stockList[i].title ..amount = _stockList[i].amount..price = _stockList[i].price..portfolio = newData.title ..date = _stockList[i].date;
        print(temp.portfolio);
        print(newData.title);
        IsarService().updateStock(_stockList[i], temp);
        _stockList[i].title = temp.title;
        _stockList[i].amount = temp.amount;
        _stockList[i].price = temp.price;
        _stockList[i].portfolio = newData.title;
        _stockList[i].date = temp.date;
      }
    }
    IsarService().updatePortfolio(oldData, newData);
    for(int i = 0; i < _portfolioList.length; i++){
      if(_portfolioList[i].id == oldData.id){
        _portfolioList[i].title = newData.title;
        break;
      }
    }
    notifyListeners();
    createPortfolio();
  }

  void changePortfolioList(List<PortfolioDataModel> portfolios) {
    _portfolioList.clear();
    _portfolioList.addAll(portfolios);
    notifyListeners();
  }

  void clearPortfolio() {
    _portfolio.clear();
    notifyListeners();
  }


  void createPortfolio() {
    _portfolio.clear();
    bool control = true;
    for (int i = 0; i < _stockList.length; i++) {
      for (int j = 0; j < _portfolio.length; j++) {
        if (_stockList[i].title == _portfolio[j].title &&
            _stockList[i].portfolio == _portfolio[j].portfolio) {
          if (_stockList[i].amount > 0) {
            _portfolio[j].dollar = (_portfolio[j].amount * (_portfolio[j].price/_portfolio[j].dollar) +
                _stockList[i].amount * (_stockList[i].price/_stockList[i].dollar)) /
                (_portfolio[j].amount + _stockList[i].amount);
            _portfolio[j].bist = (_portfolio[j].amount * (_portfolio[j].price/_portfolio[j].bist) +
                _stockList[i].amount * (_stockList[i].price/_stockList[i].bist)) /
                (_portfolio[j].amount + _stockList[i].amount);
            _portfolio[j].price = (_portfolio[j].amount * _portfolio[j].price +
                _stockList[i].amount * _stockList[i].price) /
                (_portfolio[j].amount + _stockList[i].amount);
          }
          _portfolio[j].amount += _stockList[i].amount;
          if (_portfolio[j].amount == 0) {
            _portfolio.remove(_portfolio[j]);
          }
          control = false;
          break;
        }
      }
      if (control) {
        _portfolio.add(StockDataModel()
          ..price = _stockList[i].price
          ..title = _stockList[i].title
          ..amount = _stockList[i].amount
          ..portfolio = _stockList[i].portfolio
          ..date = _stockList[i].date
          ..dollar = _stockList[i].dollar
          ..bist = _stockList[i].bist
        );
      }
      control = true;
    }
    notifyListeners();
  }

  double returnCost(String stockName) {
    for (final item in _stockList) {
      if (item.title.toUpperCase() == stockName.toUpperCase()) {
        return item.price;
      }
    }
    return 0;
  }

  int returnStockInPortfolio(String portfolioName, String stockName) {
    List<StockDataModel> items = _portfolio.where((item) {
      return item.portfolio.toUpperCase() == portfolioName.toUpperCase() &&
          item.title.toUpperCase() == stockName.toUpperCase();
    }).toList();
    return items.isEmpty ? 0 : items[0].amount;
  }

  List<StockDataModel> getStocksByPortfolio(String name) {
    if(name != "portfoliodatamodelxyz") {
      List<StockDataModel> items = _portfolio.where((item) {
        return item.portfolio.toUpperCase() == name.toUpperCase();
      }).toList();
      return items;
    }
    else{
      return _portfolio;
    }
  }

  //WATCHLIST
  void addToWatchList(WatchListDataModel newData) {
    IsarService().addWatchlist(newData);
    _watchList.add(newData);
    notifyListeners();
  }

  void deleteWatchList(WatchListDataModel newData) {
    IsarService().deleteWatchList(newData.id);
    _watchList.remove(newData);
    notifyListeners();
  }

  void changeWatchList(List<WatchListDataModel> watchlist) {
    _watchList.clear();
    _watchList.addAll(watchlist);
    notifyListeners();
  }

  void watchListCreator() {
    List<PortfolioDataModel> watchlist = [];
    bool control = true;
    for (int i = 0; i < _portfolio.length; i++) {
      for (int j = 0; j < watchlist.length; j++) {
        if (_portfolio[i].title.toUpperCase() ==
            watchlist[j].title.toUpperCase()) {
          control = false;
          break;
        }
      }
      if (control) {
        watchlist.add(PortfolioDataModel()
          ..title = _portfolio[i].title
        );
      }
      control = true;
    }
    for (int i = 0; i < watchlist.length; i++) {
      for (final item in _watchList) {
        if (item.title.toUpperCase() == watchlist[i].title.toUpperCase()) {
          control = false;
          break;
        }
      }
      if (control) {
        _watchList.add(WatchListDataModel()
          ..title = watchlist[i].title);
      }
      control = true;
    }
  }
  //CASH
  void addToCashList(CashDataModel newData) {
    for(final item in _cashList){
      if(item.portfolio == newData.portfolio){
        item.cash = newData.cash;
        IsarService().updateCash(item, newData);
        notifyListeners();
        return;
      }
    }
    IsarService().addCash(newData);
    _cashList.add(newData);
    notifyListeners();
  }
  void changeCashList(List<CashDataModel> cashlist) {
    _cashList.clear();
    _cashList.addAll(cashlist);
    notifyListeners();
  }
  double returnCash(String portfolioName) {
    for (final item in _cashList) {
      if (item.portfolio.toUpperCase() == portfolioName.toUpperCase()) {
        return item.cash;
      }
    }
    return 0;
  }
  double returnTotalCash(){
    double total = 0;
    for (final item in _cashList) {
      total += item.cash;
    }
    return total;
  }
}