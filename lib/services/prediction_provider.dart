import 'package:flutter/material.dart';
import 'package:sql_project2/services/models/advice_datamodel.dart';
import 'package:sql_project2/services/models/historical_stock_info.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class PredictionProvider extends ChangeNotifier{
  int stockCount = 0;
  bool controller = false;
  final List<StockSuggestion> _adviceList = [];
  List<StockSuggestion> get adviceList => _adviceList;
  List<String> get suggestions => _suggestions;
  final List<String> _suggestions = [];
  List<StockHistory> get stockHistory => _stockHistory;
  final List<StockHistory> _stockHistory = [
    StockHistory()
      ..symbol = "THYAO"
      ..stdFK = 1.88
      ..stdPDDD = 0.34
      ..stdFAV = 4.05
      ..averageFK =5.86
      ..averagePDDD =0.67
      ..averageFAV =8.93
      ..lowFK = 3.45
      ..lowPDDD = 0.3
      ..lowFAV = 4.19
      ..highFK = 11.12
      ..highPDDD = 1.93
      ..highFAV = 17.09,


    StockHistory()
      ..symbol = "TOASO"
      ..stdFK = 2.16
      ..stdPDDD = 2.53
      ..stdFAV = 1.46
      ..averageFK =9.47
      ..averagePDDD =6.39
      ..averageFAV =6.81
      ..lowFK = 5.54
      ..lowPDDD = 2.4
      ..lowFAV = 4.41
      ..highFK = 15.56
      ..highPDDD = 12.18
      ..highFAV = 11.05,


    StockHistory()
      ..symbol = "FROTO"
      ..stdFK = 2.08
      ..stdPDDD = 1.65
      ..stdFAV = 1.41
      ..averageFK =11.44
      ..averagePDDD =9.29
      ..averageFAV =10.49
      ..lowFK = 7.94
      ..lowPDDD = 5.61
      ..lowFAV = 7.69
      ..highFK = 18.03
      ..highPDDD = 15.35
      ..highFAV = 15.47,


    StockHistory()
      ..symbol = "ANHYT"
      ..stdFK = 1.10
      ..stdPDDD = 0.52
      ..stdFAV = -1.00
      ..averageFK =6.63
      ..averagePDDD =2.57
      ..averageFAV =0.00
      ..lowFK = 3.98
      ..lowPDDD = 1.86
      ..lowFAV = -1
      ..highFK = 10.44
      ..highPDDD = 5.38
      ..highFAV = 0,


    StockHistory()
      ..symbol = "PGSUS"
      ..stdFK = 5.76
      ..stdPDDD = 1.12
      ..stdFAV = 36.05
      ..averageFK =13.55
      ..averagePDDD =2.29
      ..averageFAV =28.83
      ..lowFK = 3.91
      ..lowPDDD = 0.85
      ..lowFAV = 3.71
      ..highFK = 28.4
      ..highPDDD = 5.63
      ..highFAV = 143.63,


    StockHistory()
      ..symbol = "TUPRS"
      ..stdFK = 11.85
      ..stdPDDD = 0.68
      ..stdFAV = 19.88
      ..averageFK =12.22
      ..averagePDDD =2.79
      ..averageFAV =15.92
      ..lowFK = 2.63
      ..lowPDDD = 1.83
      ..lowFAV = 1.82
      ..highFK = 40.74
      ..highPDDD = 4.79
      ..highFAV = 74.73,


    StockHistory()
      ..symbol = "ISMEN"
      ..stdFK = 1.36
      ..stdPDDD = 0.82
      ..stdFAV = 1.25
      ..averageFK =5.21
      ..averagePDDD =2.71
      ..averageFAV =3.31
      ..lowFK = 2.87
      ..lowPDDD = 1.63
      ..lowFAV = 1.21
      ..highFK = 9.5
      ..highPDDD = 6.16
      ..highFAV = 6.92,


    StockHistory()
      ..symbol = "TTRAK"
      ..stdFK = 3.64
      ..stdPDDD = 3.02
      ..stdFAV = 2.07
      ..averageFK =10.53
      ..averagePDDD =8.27
      ..averageFAV =7.61
      ..lowFK = 5.6
      ..lowPDDD = 4.51
      ..lowFAV = 3.98
      ..highFK = 21.01
      ..highPDDD = 20.58
      ..highFAV = 14.7,


    StockHistory()
      ..symbol = "OTKAR"
      ..stdFK = 18.37
      ..stdPDDD = 4.11
      ..stdFAV = 9.58
      ..averageFK =18.29
      ..averagePDDD =9.82
      ..averageFAV =17.75
      ..lowFK = 8.15
      ..lowPDDD = 5.01
      ..lowFAV = 9.33
      ..highFK = 98.38
      ..highPDDD = 25.16
      ..highFAV = 53.14,


    StockHistory()
      ..symbol = "ISCTR"
      ..stdFK = 0.58
      ..stdPDDD = 0.16
      ..stdFAV = -1.00
      ..averageFK =2.76
      ..averagePDDD =0.44
      ..averageFAV =0.00
      ..lowFK = 1.55
      ..lowPDDD = 0.25
      ..lowFAV = -1
      ..highFK = 4.18
      ..highPDDD = 1.06
      ..highFAV = 0,


    StockHistory()
      ..symbol = "SISE"
      ..stdFK = 2.33
      ..stdPDDD = 0.38
      ..stdFAV = 1.02
      ..averageFK =7.63
      ..averagePDDD =1.36
      ..averageFAV =6.86
      ..lowFK = 3.8
      ..lowPDDD = 0.81
      ..lowFAV = 4.31
      ..highFK = 14.96
      ..highPDDD = 2.35
      ..highFAV = 9.79,


    StockHistory()
      ..symbol = "MAVI"
      ..stdFK = 124.62
      ..stdPDDD = 0.95
      ..stdFAV = 1.27
      ..averageFK =64.54
      ..averagePDDD =4.48
      ..averageFAV =5.17
      ..lowFK = 6.62
      ..lowPDDD = 2.81
      ..lowFAV = 2.98
      ..highFK = 595.49
      ..highPDDD = 8.62
      ..highFAV = 8.43,


    StockHistory()
      ..symbol = "MGROS"
      ..stdFK = 14.12
      ..stdPDDD = 110.76
      ..stdFAV = 1.08
      ..averageFK =26.49
      ..averagePDDD =87.17
      ..averageFAV =4.67
      ..lowFK = 9.48
      ..lowPDDD = 6.23
      ..lowFAV = 3.09
      ..highFK = 66.05
      ..highPDDD = 435.42
      ..highFAV = 9.03,


    StockHistory()
      ..symbol = "AKSA"
      ..stdFK = 2.54
      ..stdPDDD = 1.41
      ..stdFAV = 0.98
      ..averageFK =9.97
      ..averagePDDD =3.72
      ..averageFAV =6.86
      ..lowFK = 5.41
      ..lowPDDD = 1.17
      ..lowFAV = 4.76
      ..highFK = 20.45
      ..highPDDD = 6.8
      ..highFAV = 9.39,


    StockHistory()
      ..symbol = "ALARK"
      ..stdFK = 2.86
      ..stdPDDD = 0.75
      ..stdFAV = 60.23
      ..averageFK =5.83
      ..averagePDDD =2.32
      ..averageFAV =48.97
      ..lowFK = 1.8
      ..lowPDDD = 1.19
      ..lowFAV = 4.39
      ..highFK = 16.68
      ..highPDDD = 4.99
      ..highFAV = 343.38,


    StockHistory()
      ..symbol = "ARCLK"
      ..stdFK = 6.39
      ..stdPDDD = 0.75
      ..stdFAV = 1.80
      ..averageFK =13.51
      ..averagePDDD =2.13
      ..averageFAV =7.29
      ..lowFK = 5.13
      ..lowPDDD = 1.15
      ..lowFAV = 4.45
      ..highFK = 32.86
      ..highPDDD = 4.39
      ..highFAV = 11.15,


    StockHistory()
      ..symbol = "BIMAS"
      ..stdFK = 2.90
      ..stdPDDD = 1.32
      ..stdFAV = 1.21
      ..averageFK =15.10
      ..averagePDDD =6.27
      ..averageFAV =8.56
      ..lowFK = 9.77
      ..lowPDDD = 3.05
      ..lowFAV = 6.7
      ..highFK = 24.99
      ..highPDDD = 9.94
      ..highFAV = 13.84,


    StockHistory()
      ..symbol = "DOAS"
      ..stdFK = 1.38
      ..stdPDDD = 0.72
      ..stdFAV = 0.94
      ..averageFK =4.83
      ..averagePDDD =2.70
      ..averageFAV =4.29
      ..lowFK = 2.44
      ..lowPDDD = 1.55
      ..lowFAV = 2.53
      ..highFK = 10.45
      ..highPDDD = 4.48
      ..highFAV = 6.58,


    StockHistory()
      ..symbol = "EGEEN"
      ..stdFK = 4.46
      ..stdPDDD = 2.29
      ..stdFAV = 5.93
      ..averageFK =14.13
      ..averagePDDD =6.91
      ..averageFAV =18.24
      ..lowFK = 7.04
      ..lowPDDD = 2.36
      ..lowFAV = 6.21
      ..highFK = 27.09
      ..highPDDD = 14.24
      ..highFAV = 32.31,


    StockHistory()
      ..symbol = "EREGL"
      ..stdFK = 14.43
      ..stdPDDD = 0.26
      ..stdFAV = 2.56
      ..averageFK =12.19
      ..averagePDDD =1.17
      ..averageFAV =5.28
      ..lowFK = 4.42
      ..lowPDDD = 0.62
      ..lowFAV = 2.85
      ..highFK = 92.34
      ..highPDDD = 1.98
      ..highFAV = 17.91,


    StockHistory()
      ..symbol = "ISDMR"
      ..stdFK = 6.41
      ..stdPDDD = 0.44
      ..stdFAV = 28.07
      ..averageFK =12.37
      ..averagePDDD =1.55
      ..averageFAV =12.70
      ..lowFK = -56.59
      ..lowPDDD = 0.74
      ..lowFAV = 2.91
      ..highFK = 36.46
      ..highPDDD = 2.91
      ..highFAV = 170.31,


    StockHistory()
      ..symbol = "KCHOL"
      ..stdFK = 1.18
      ..stdPDDD = 0.28
      ..stdFAV = 2.28
      ..averageFK =4.90
      ..averagePDDD =1.25
      ..averageFAV =5.17
      ..lowFK = 2.31
      ..lowPDDD = 0.8
      ..lowFAV = 1.97
      ..highFK = 7.65
      ..highPDDD = 2.16
      ..highFAV = 12.26,


    StockHistory()
      ..symbol = "PETKM"
      ..stdFK = 6.66
      ..stdPDDD = 0.32
      ..stdFAV = 38.75
      ..averageFK =9.35
      ..averagePDDD =1.97
      ..averageFAV =17.89
      ..lowFK = 3.18
      ..lowPDDD = 1.41
      ..lowFAV = 4.25
      ..highFK = 26.56
      ..highPDDD = 2.83
      ..highFAV = 234.9,


    StockHistory()
      ..symbol = "SASA"
      ..stdFK = 103.17
      ..stdPDDD = 4.96
      ..stdFAV = 15.90
      ..averageFK =79.61
      ..averagePDDD =13.25
      ..averageFAV =37.62
      ..lowFK = 12.68
      ..lowPDDD = 3.5
      ..lowFAV = 17.33
      ..highFK = 529.51
      ..highPDDD = 32.78
      ..highFAV = 84.95,


    StockHistory()
      ..symbol = "VESBE"
      ..stdFK = 4.10
      ..stdPDDD = 0.52
      ..stdFAV = 1.61
      ..averageFK =8.88
      ..averagePDDD =2.74
      ..averageFAV =6.03
      ..lowFK = 4.56
      ..lowPDDD = 1.91
      ..lowFAV = 3.9
      ..highFK = 24.79
      ..highPDDD = 4.46
      ..highFAV = 12.06,


    StockHistory()
      ..symbol = "TAVHL"
      ..stdFK = 41.30
      ..stdPDDD = 0.26
      ..stdFAV = 31.11
      ..averageFK =44.60
      ..averagePDDD =1.07
      ..averageFAV =26.91
      ..lowFK = 5.88
      ..lowPDDD = 0.55
      ..lowFAV = 8.03
      ..highFK = 175.55
      ..highPDDD = 1.82
      ..highFAV = 151.13,


    StockHistory()
      ..symbol = "SAHOL"
      ..stdFK = 0.72
      ..stdPDDD = 0.21
      ..stdFAV = 0.60
      ..averageFK =2.93
      ..averagePDDD =0.66
      ..averageFAV =2.04
      ..lowFK = 1.69
      ..lowPDDD = 0.38
      ..lowFAV = 0.66
      ..highFK = 4.47
      ..highPDDD = 1.19
      ..highFAV = 3.24,
  ];
  List<String> get hisseFK => _hisseFK;
  final List<String> _hisseFK = [];
  List<String> get hissePDDD => _hissePDDD;
  final List<String> _hissePDDD = [];

  Future<void> getRatios() async {
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
            adviceList.add(StockSuggestion(symbol: _stockHistory[i].symbol, suggestion: returnAdvise(_stockHistory[i].symbol, double.parse(ratioElement!.text.replaceAll(',', '.')), double.parse(ratioElement2!.text.replaceAll(',', '.'))))
            );
        }
      } else {
        throw Exception('Failed to load page');
      }

    }
    controller = true;
    notifyListeners();
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