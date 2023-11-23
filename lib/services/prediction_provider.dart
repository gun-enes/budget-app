import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/invest_provider.dart';
import 'package:sql_project2/services/models/advice_datamodel.dart';
import 'package:sql_project2/services/models/historical_stock_info.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class PredictionProvider extends ChangeNotifier{
  int stockCount = 0;
  bool controller = false;
  InvestProvider investProvider = InvestProvider();
  List<String> get hissekodlari => _hissekodlari;
  final List<String> _hissekodlari = [];
  List<String> get hissefiyati => _hissefiyati;
  final List<String> _hissefiyati = [];
  final List<StockSuggestion> _adviceList = [];
  List<StockSuggestion> get adviceList => _adviceList;
  List<String> get suggestions => _suggestions;
  final List<String> _suggestions = [];
  List<StockHistory> get stockHistory => _stockHistory;
  final List<StockHistory> _stockHistory = [StockHistory()
    ..symbol = "GUBRF"
    ..stdFK = 20.22
    ..stdPDDD = 4.47
    ..stdFAV = 48.64
    ..averageFK =59.96
    ..averagePDDD =13.73
    ..averageFAV =33.80
    ..lowFK = -532.24
    ..lowPDDD = 6.52
    ..lowFAV = 7.41
    ..highFK = 114.4
    ..highPDDD = 27.81
    ..highFAV = 228.93,


    StockHistory()
      ..symbol = "KRDMD"
      ..stdFK = 7.20
      ..stdPDDD = 0.48
      ..stdFAV = 1.99
      ..averageFK =8.04
      ..averagePDDD =1.74
      ..averageFAV =3.57
      ..lowFK = 2.49
      ..lowPDDD = 1.03
      ..lowFAV = 1.1
      ..highFK = 31.82
      ..highPDDD = 3.23
      ..highFAV = 9.23,


    StockHistory()
      ..symbol = "ASELS"
      ..stdFK = 2.56
      ..stdPDDD = 0.87
      ..stdFAV = 3.42
      ..averageFK =9.85
      ..averagePDDD =2.90
      ..averageFAV =13.39
      ..lowFK = 6.46
      ..lowPDDD = 1.8
      ..lowFAV = 9.22
      ..highFK = 16.11
      ..highPDDD = 5.11
      ..highFAV = 23.15,


    StockHistory()
      ..symbol = "OYAKC"
      ..stdFK = 4.04
      ..stdPDDD = 1.73
      ..stdFAV = 2.70
      ..averageFK =13.78
      ..averagePDDD =5.40
      ..averageFAV =11.78
      ..lowFK = 6.66
      ..lowPDDD = 2.95
      ..lowFAV = 7.64
      ..highFK = 31.85
      ..highPDDD = 13.09
      ..highFAV = 24.36,


    StockHistory()
      ..symbol = "YUNSA"
      ..stdFK = 6.13
      ..stdPDDD = 2.44
      ..stdFAV = 4.38
      ..averageFK =10.48
      ..averagePDDD =6.18
      ..averageFAV =8.40
      ..lowFK = 5.89
      ..lowPDDD = 1.83
      ..lowFAV = 4.54
      ..highFK = 23.39
      ..highPDDD = 12.82
      ..highFAV = 26.15,


    StockHistory()
      ..symbol = "ANSGR"
      ..stdFK = 2.05
      ..stdPDDD = 0.62
      ..stdFAV = -1.00
      ..averageFK =6.66
      ..averagePDDD =1.67
      ..averageFAV =0.00
      ..lowFK = 3.46
      ..lowPDDD = 0.87
      ..lowFAV = -1
      ..highFK = 12.22
      ..highPDDD = 3.67
      ..highFAV = 0,


    StockHistory()
      ..symbol = "THYAO"
      ..stdFK = 1.16
      ..stdPDDD = 0.31
      ..stdFAV = 1.09
      ..averageFK =5.39
      ..averagePDDD =0.90
      ..averageFAV =5.93
      ..lowFK = 3.45
      ..lowPDDD = 0.38
      ..lowFAV = 4.19
      ..highFK = 8.3
      ..highPDDD = 1.93
      ..highFAV = 7.85,


    StockHistory()
      ..symbol = "TOASO"
      ..stdFK = 1.55
      ..stdPDDD = 1.43
      ..stdFAV = 1.45
      ..averageFK =10.49
      ..averagePDDD =8.34
      ..averageFAV =7.17
      ..lowFK = 7.0
      ..lowPDDD = 5.6
      ..lowFAV = 4.41
      ..highFK = 13.72
      ..highPDDD = 12.18
      ..highFAV = 10.19,


    StockHistory()
      ..symbol = "FROTO"
      ..stdFK = 1.55
      ..stdPDDD = 1.38
      ..stdFAV = 1.30
      ..averageFK =10.78
      ..averagePDDD =10.28
      ..averageFAV =10.92
      ..lowFK = 8.2
      ..lowPDDD = 7.59
      ..lowFAV = 8.66
      ..highFK = 16.0
      ..highPDDD = 15.35
      ..highFAV = 15.47,


    StockHistory()
      ..symbol = "ANHYT"
      ..stdFK = 1.31
      ..stdPDDD = 0.62
      ..stdFAV = -1.00
      ..averageFK =6.70
      ..averagePDDD =2.72
      ..averageFAV =0.00
      ..lowFK = 3.98
      ..lowPDDD = 1.86
      ..lowFAV = -1
      ..highFK = 10.44
      ..highPDDD = 5.38
      ..highFAV = 0,


    StockHistory()
      ..symbol = "PGSUS"
      ..stdFK = 7.17
      ..stdPDDD = 1.00
      ..stdFAV = 4.84
      ..averageFK =13.86
      ..averagePDDD =3.04
      ..averageFAV =12.51
      ..lowFK = 5.46
      ..lowPDDD = 1.26
      ..lowFAV = 6.15
      ..highFK = 28.4
      ..highPDDD = 5.63
      ..highFAV = 19.52,


    StockHistory()
      ..symbol = "TUPRS"
      ..stdFK = 5.67
      ..stdPDDD = 0.72
      ..stdFAV = 1.72
      ..averageFK =8.58
      ..averagePDDD =3.10
      ..averageFAV =3.70
      ..lowFK = 2.63
      ..lowPDDD = 2.0
      ..lowFAV = 1.82
      ..highFK = 21.95
      ..highPDDD = 4.79
      ..highFAV = 9.44,


    StockHistory()
      ..symbol = "ISMEN"
      ..stdFK = 1.47
      ..stdPDDD = 0.99
      ..stdFAV = 1.43
      ..averageFK =5.33
      ..averagePDDD =2.88
      ..averageFAV =3.76
      ..lowFK = 2.87
      ..lowPDDD = 1.81
      ..lowFAV = 1.21
      ..highFK = 9.5
      ..highPDDD = 6.16
      ..highFAV = 6.92,


    StockHistory()
      ..symbol = "TTRAK"
      ..stdFK = 2.51
      ..stdPDDD = 3.40
      ..stdFAV = 2.01
      ..averageFK =9.80
      ..averagePDDD =9.63
      ..averageFAV =7.89
      ..lowFK = 6.9
      ..lowPDDD = 4.55
      ..lowFAV = 5.13
      ..highFK = 17.94
      ..highPDDD = 20.58
      ..highFAV = 14.7,


    StockHistory()
      ..symbol = "OTKAR"
      ..stdFK = 23.42
      ..stdPDDD = 4.82
      ..stdFAV = 11.11
      ..averageFK =24.07
      ..averagePDDD =11.37
      ..averageFAV =22.08
      ..lowFK = 8.42
      ..lowPDDD = 5.97
      ..lowFAV = 11.68
      ..highFK = 98.38
      ..highPDDD = 25.16
      ..highFAV = 53.14,


    StockHistory()
      ..symbol = "ISCTR"
      ..stdFK = 0.52
      ..stdPDDD = 0.15
      ..stdFAV = -1.00
      ..averageFK =2.40
      ..averagePDDD =0.55
      ..averageFAV =0.00
      ..lowFK = 1.55
      ..lowPDDD = 0.32
      ..lowFAV = -1
      ..highFK = 4.07
      ..highPDDD = 1.06
      ..highFAV = 0,


    StockHistory()
      ..symbol = "SISE"
      ..stdFK = 1.30
      ..stdPDDD = 0.31
      ..stdFAV = 0.79
      ..averageFK =6.34
      ..averagePDDD =1.62
      ..averageFAV =7.36
      ..lowFK = 3.8
      ..lowPDDD = 0.88
      ..lowFAV = 5.98
      ..highFK = 9.39
      ..highPDDD = 2.35
      ..highFAV = 9.79,


    StockHistory()
      ..symbol = "MAVI"
      ..stdFK = 1.74
      ..stdPDDD = 1.23
      ..stdFAV = 1.07
      ..averageFK =9.26
      ..averagePDDD =4.55
      ..averageFAV =4.46
      ..lowFK = 6.62
      ..lowPDDD = 2.81
      ..lowFAV = 2.98
      ..highFK = 14.24
      ..highPDDD = 8.62
      ..highFAV = 7.93,


    StockHistory()
      ..symbol = "MGROS"
      ..stdFK = 8.76
      ..stdPDDD = 8.70
      ..stdFAV = 1.29
      ..averageFK =21.29
      ..averagePDDD =14.27
      ..averageFAV =4.71
      ..lowFK = 9.48
      ..lowPDDD = 6.23
      ..lowFAV = 3.09
      ..highFK = 46.67
      ..highPDDD = 45.66
      ..highFAV = 9.03,


    StockHistory()
      ..symbol = "KAYSE"
      ..stdFK = 2.11
      ..stdPDDD = 0.70
      ..stdFAV = 3.48
      ..averageFK =5.05
      ..averagePDDD =1.71
      ..averageFAV =10.18
      ..lowFK = 2.57
      ..lowPDDD = 0.89
      ..lowFAV = 6.12
      ..highFK = 9.21
      ..highPDDD = 3.18
      ..highFAV = 17.98,


    StockHistory()
      ..symbol = "VESTL"
      ..stdFK = 18.39
      ..stdPDDD = 0.39
      ..stdFAV = 1.29
      ..averageFK =16.46
      ..averagePDDD =1.31
      ..averageFAV =4.84
      ..lowFK = -19.63
      ..lowPDDD = 0.76
      ..lowFAV = 3.25
      ..highFK = 65.08
      ..highPDDD = 2.29
      ..highFAV = 7.24,


    StockHistory()
      ..symbol = "AKSA"
      ..stdFK = 1.92
      ..stdPDDD = 0.89
      ..stdFAV = 0.93
      ..averageFK =9.37
      ..averagePDDD =4.77
      ..averageFAV =7.08
      ..lowFK = 5.41
      ..lowPDDD = 2.92
      ..lowFAV = 4.89
      ..highFK = 13.1
      ..highPDDD = 6.8
      ..highFAV = 9.07,


    StockHistory()
      ..symbol = "ALARK"
      ..stdFK = 1.97
      ..stdPDDD = 0.66
      ..stdFAV = 67.36
      ..averageFK =5.03
      ..averagePDDD =2.81
      ..averageFAV =85.77
      ..lowFK = 1.8
      ..lowPDDD = 1.32
      ..lowFAV = 17.3
      ..highFK = 9.46
      ..highPDDD = 4.99
      ..highFAV = 343.38,


    StockHistory()
      ..symbol = "ARCLK"
      ..stdFK = 4.87
      ..stdPDDD = 0.61
      ..stdFAV = 0.87
      ..averageFK =18.20
      ..averagePDDD =2.67
      ..averageFAV =8.78
      ..lowFK = 9.29
      ..lowPDDD = 1.72
      ..lowFAV = 6.6
      ..highFK = 32.86
      ..highPDDD = 4.39
      ..highFAV = 11.15,


    StockHistory()
      ..symbol = "BIMAS"
      ..stdFK = 2.09
      ..stdPDDD = 1.59
      ..stdFAV = 1.28
      ..averageFK =14.47
      ..averagePDDD =6.12
      ..averageFAV =8.73
      ..lowFK = 9.77
      ..lowPDDD = 3.05
      ..lowFAV = 6.99
      ..highFK = 20.27
      ..highPDDD = 9.94
      ..highFAV = 13.84,


    StockHistory()
      ..symbol = "DOAS"
      ..stdFK = 0.88
      ..stdPDDD = 0.66
      ..stdFAV = 0.86
      ..averageFK =4.55
      ..averagePDDD =3.14
      ..averageFAV =4.32
      ..lowFK = 2.44
      ..lowPDDD = 1.85
      ..lowFAV = 2.53
      ..highFK = 6.22
      ..highPDDD = 4.48
      ..highFAV = 6.05,


    StockHistory()
      ..symbol = "EGEEN"
      ..stdFK = 5.18
      ..stdPDDD = 2.51
      ..stdFAV = 5.61
      ..averageFK =14.00
      ..averagePDDD =7.87
      ..averageFAV =18.26
      ..lowFK = 7.04
      ..lowPDDD = 4.51
      ..lowFAV = 9.95
      ..highFK = 27.09
      ..highPDDD = 14.24
      ..highFAV = 32.31,


    StockHistory()
      ..symbol = "EREGL"
      ..stdFK = 19.05
      ..stdPDDD = 0.19
      ..stdFAV = 3.31
      ..averageFK =11.98
      ..averagePDDD =1.20
      ..averageFAV =5.39
      ..lowFK = 4.42
      ..lowPDDD = 0.87
      ..lowFAV = 2.91
      ..highFK = 92.34
      ..highPDDD = 1.86
      ..highFAV = 17.91,


    StockHistory()
      ..symbol = "ISDMR"
      ..stdFK = 7.78
      ..stdPDDD = 0.25
      ..stdFAV = 37.58
      ..averageFK =14.12
      ..averagePDDD =1.85
      ..averageFAV =18.13
      ..lowFK = -56.59
      ..lowPDDD = 1.35
      ..lowFAV = 3.45
      ..highFK = 36.46
      ..highPDDD = 2.91
      ..highFAV = 170.31,


    StockHistory()
      ..symbol = "KCHOL"
      ..stdFK = 1.19
      ..stdPDDD = 0.23
      ..stdFAV = 1.09
      ..averageFK =4.22
      ..averagePDDD =1.43
      ..averageFAV =3.51
      ..lowFK = 2.31
      ..lowPDDD = 1.1
      ..lowFAV = 1.97
      ..highFK = 7.03
      ..highPDDD = 2.16
      ..highFAV = 5.9,


    StockHistory()
      ..symbol = "PETKM"
      ..stdFK = 3.65
      ..stdPDDD = 0.33
      ..stdFAV = 51.74
      ..averageFK =6.16
      ..averagePDDD =2.01
      ..averageFAV =25.66
      ..lowFK = 3.18
      ..lowPDDD = 1.41
      ..lowFAV = 4.5
      ..highFK = 20.79
      ..highPDDD = 2.83
      ..highFAV = 234.9,


    StockHistory()
      ..symbol = "SASA"
      ..stdFK = 23.18
      ..stdPDDD = 3.65
      ..stdFAV = 19.36
      ..averageFK =40.87
      ..averagePDDD =16.52
      ..averageFAV =41.02
      ..lowFK = 19.53
      ..lowPDDD = 10.36
      ..lowFAV = 17.33
      ..highFK = 113.5
      ..highPDDD = 32.78
      ..highFAV = 84.95,


    StockHistory()
      ..symbol = "VESBE"
      ..stdFK = 4.53
      ..stdPDDD = 0.52
      ..stdFAV = 1.68
      ..averageFK =10.98
      ..averagePDDD =2.95
      ..averageFAV =6.89
      ..lowFK = 5.61
      ..lowPDDD = 2.12
      ..lowFAV = 4.65
      ..highFK = 24.79
      ..highPDDD = 4.46
      ..highFAV = 12.06,


    StockHistory()
      ..symbol = "TAVHL"
      ..stdFK = 47.66
      ..stdPDDD = 0.20
      ..stdFAV = 3.78
      ..averageFK =35.50
      ..averagePDDD =1.23
      ..averageFAV =12.88
      ..lowFK = 13.65
      ..lowPDDD = 0.73
      ..lowFAV = 8.03
      ..highFK = 166.52
      ..highPDDD = 1.82
      ..highFAV = 20.07,


    StockHistory()
      ..symbol = "SAHOL"
      ..stdFK = 0.50
      ..stdPDDD = 0.16
      ..stdFAV = 0.49
      ..averageFK =2.42
      ..averagePDDD =0.81
      ..averageFAV =1.65
      ..lowFK = 1.69
      ..lowPDDD = 0.55
      ..lowFAV = 0.66
      ..highFK = 3.86
      ..highPDDD = 1.19
      ..highFAV = 2.32,
  ];
  List<String> get hisseFK => _hisseFK;
  final List<String> _hisseFK = [];
  List<String> get hissePDDD => _hissePDDD;
  final List<String> _hissePDDD = [];

  Future getData() async {
    final url1 = Uri.parse(
        'https://www.oyakyatirim.com.tr/piyasa-verileri/XUTUM');
    final response1 = await http.get(url1);
    dom.Document html1 = dom.Document.html(response1.body);
    final titles1 = html1.querySelectorAll('table > tbody > tr > td').map((e) =>
        e.innerHtml.trim()).toList();
    _hissekodlari.clear();
    _hissefiyati.clear();
    for (int i = 18; i < titles1.length - 3; i = i + 10) {
      if (titles1[i][26] == "\"") {
        _hissekodlari.add(titles1[i].substring(22, 26));
      }
      else {
        _hissekodlari.add(titles1[i].substring(22, 27));
      }
      _hissefiyati.add(titles1[i + 2]);
    }
    notifyListeners();
  }
  Future<void> getRatios() async {
    getData();
    stockCount = 0;
    for (int i = 0; i < _stockHistory.length; i++) {
      String code = _stockHistory[i].symbol;
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
            adviceList.add(StockSuggestion(symbol: _stockHistory[i].symbol, suggestion: returnAdvise2(_stockHistory[i].symbol, double.parse(ratioElement!.text.replaceAll(',', '.')), double.parse(ratioElement2!.text.replaceAll(',', '.')), returnPrice(_stockHistory[i].symbol) ))
            );
        }
      } else {
        throw Exception('Failed to load page');
      }

    }
    controller = true;
    notifyListeners();
  }
  double returnValuePrice(String symbol, double fk, double pddd,double price){
    double value1 = (price/fk)*returnAverageFK(symbol);
    double value2 = (price/pddd)*returnAveragePDDD(symbol);
    return (value1+value2)/2;
  }
  
  String returnAdvise2(String symbol,double fk, double pddd, double price){
    print(price);
    print(returnValuePrice(symbol, fk, pddd, price));
   if(returnValuePrice(symbol, fk + returnStdFK(symbol), pddd + returnStdFK(symbol), price)> price){
     return "GÜÇLÜ AL";
   }
    else if(returnValuePrice(symbol, fk, pddd, price) > price){
      return "AL";}
    else if(returnValuePrice(symbol, fk, pddd, price) < price){
      return "SAT";
    }
    else if(returnValuePrice(symbol, fk - returnStdFK(symbol), pddd - returnStdFK(symbol), price) < price){
      return "GÜÇLÜ SAT";
    }
    else{
      return "TUT";
    }
   }

  String returnAdvise(String symbol, double fk, double pddd){
    if(fk < returnAverageFK(symbol)-returnStdFK(symbol) && pddd < returnAveragePDDD(symbol)-returnStdPDDD(symbol)){

      return "GÜÇLÜ AL";
    }
    else if(fk < returnAverageFK(symbol)-returnStdFK(symbol) || pddd < returnAveragePDDD(symbol)-returnStdPDDD(symbol)){
      return "AL";
    }
    else if(fk > returnAverageFK(symbol)+returnStdFK(symbol) || pddd > returnAveragePDDD(symbol)+returnStdPDDD(symbol)){
      return "SAT";
    }
    else if(fk > returnAverageFK(symbol)+returnStdFK(symbol) && pddd > returnAveragePDDD(symbol)+returnStdPDDD(symbol)){
      return "GÜÇLÜ SAT";
    }
    else{
      return "TUT";
    }
  }
  double returnPercentFK(String symbol, double fk){
    return ((fk-returnAverageFK(symbol)+returnStdFK(symbol))/(returnAverageFK(symbol)+returnStdFK(symbol)))*100;
  }
  double returnPercentPDDD(String symbol, double pddd){
    return ((pddd-returnAveragePDDD(symbol)+returnStdPDDD(symbol))/(returnAveragePDDD(symbol)+returnStdPDDD(symbol)))*100;
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
  double returnStdFK(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].stdFK;
      }
    }
    return -1;
  }
  double returnStdPDDD(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].stdPDDD;
      }
    }
    return -1;
  }
  double returnStdFAV(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].stdFAV;
      }
    }
    return -1;
  }

  double returnAverageFK(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].averageFK;
      }
    }
    return -1;
  }

  double returnAveragePDDD(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].averagePDDD;
      }
    }
    return -1;
  }
  double returnAverageFAV(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].averageFAV;
      }
    }
    return -1;
  }
  double returnLowFK(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].lowFK;
      }
    }
    return -1;
  }
  double returnLowPDDD(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].lowPDDD;
      }
    }
    return -1;
  }
  double returnLowFAV(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].lowFAV;
      }
    }
    return -1;
  }
  double returnHighFK(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].highFK;
      }
    }
    return -1;
  }
  double returnHighPDDD(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].highPDDD;
      }
    }
    return -1;
  }
  double returnHighFAV(String symbol){
    for (var i = 0; i < _stockHistory.length; i++) {
      if(_stockHistory[i].symbol == symbol){
        return _stockHistory[i].highFAV;
      }
    }
    return -1;
  }

}