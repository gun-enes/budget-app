import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';
import 'package:sql_project2/services/invest_provider.dart';
import 'package:sql_project2/services/prediction_provider.dart';
class StockInfo extends StatefulWidget {
  final String code;
  const StockInfo({Key? key, required this.code}) : super(key: key);

  @override
  State<StockInfo> createState() => _StockInfoState();
}

class _StockInfoState extends State<StockInfo> {
  //List<String> ratios = [];
  final List<String> _ratios = [];
  bool controller = false;
  @override
  Widget build(BuildContext context) {
    //ratios = getRatios(widget.code);
    getRatios(widget.code);
    PredictionProvider predictionProvider = Provider.of<PredictionProvider>(context);
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.code} Analiz"),
      ),
      body: Center(
        child: controller ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mevcut Fiyat: ", style: TextStyle(fontSize: 20),),
                        Text("Adil Fiyat: ", style: TextStyle(fontSize: 20),),
                        Text("F/K: ", style: TextStyle(fontSize: 20),),
                        Text("PD/DD: ", style: TextStyle(fontSize: 20),),
                        Text("FD/FAVÖK: ", style: TextStyle(fontSize: 20),),
                        Text("F/K Ortalama: ", style: TextStyle(fontSize: 20),),
                        Text("PD/DD Ortalama: ", style: TextStyle(fontSize: 20),),
                        Text("FD/FAVÖK Ortalama: ", style: TextStyle(fontSize: 20),),
                        Text("F/K Standart Sapma: ", style: TextStyle(fontSize: 20),),
                        Text("PD/DD Standart Sapma: ", style: TextStyle(fontSize: 20),),
                        Text("FD/FAVÖK Standart Sapma: ", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      children: [
                        Text("${investProvider.returnPrice(widget.code)}", style: const TextStyle(fontSize: 20),),
                        if(_ratios[0] != 'A/D' && _ratios[1] != 'A/D')
                        Text(predictionProvider.returnValuePrice(widget.code, double.parse(_ratios[0].replaceAll(",", ".")), double.parse(_ratios[1].replaceAll(",", ".")), investProvider.returnPrice(widget.code)).toStringAsFixed(2), style: TextStyle(fontSize: 20),)
                        else
                          const Text("-", style: TextStyle(fontSize: 20),),
                        Text("${_ratios[0]}", style: const TextStyle(fontSize: 20),),
                        Text("${_ratios[1]}", style: const TextStyle(fontSize: 20),),
                        Text("${_ratios[2]}", style: const TextStyle(fontSize: 20),),
                        Text("${predictionProvider.returnAverageFK(widget.code)}", style: const TextStyle(fontSize: 20),),
                        Text("${predictionProvider.returnAveragePDDD(widget.code)}", style: const TextStyle(fontSize: 20),),
                        Text("${predictionProvider.returnAverageFAV(widget.code)}", style: const TextStyle(fontSize: 20),),
                        Text("${predictionProvider.returnStdFK(widget.code)}", style: const TextStyle(fontSize: 20),),
                        Text("${predictionProvider.returnStdPDDD(widget.code)}", style: const TextStyle(fontSize: 20),),
                        Text("${predictionProvider.returnStdFAV(widget.code)}", style: const TextStyle(fontSize: 20),),
                      ],
                    ),
                  )

                ],
              ),/*
              if(predictionProvider.returnAverageFK(widget.code) != -1)
                Row(
                  children: [
                    Column(
                      children: [
                        if(_ratios[0] != 'A/D' && _ratios[1] != 'A/D')
                          Text(predictionProvider.returnPercentFK(widget.code, double.parse(_ratios[0].replaceAll(",", "."))).toStringAsFixed(2),style: const TextStyle(
                              fontSize: 30, color: Colors.green),),
                        Text(predictionProvider.returnPercentPDDD(widget.code, double.parse(_ratios[1].replaceAll(",", "."))).toStringAsFixed(2),style: const TextStyle(
                            fontSize: 30, color: Colors.green),),

                        Text(
                          predictionProvider.returnAdvise(widget.code, double.parse(_ratios[0].replaceAll(",", ".")), double.parse(_ratios[1].replaceAll(",", "."))),
                          style: const TextStyle(
                              fontSize: 30, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),*/

            ],
          ):const CircularProgressIndicator()
      ),
    );
  }
  Future<void> getRatios(String code) async {
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
          '#ctl00_ctl58_g_76ae4504_9743_4791_98df_dce2ca95cc0d > div.box-content > div > table > tbody > tr:nth-child(7) > td');
      final ratioElement4 = htmlRatios.querySelector(
          '#ctl00_ctl58_g_76ae4504_9743_4791_98df_dce2ca95cc0d > div.box-content > div > table > tbody > tr:nth-child(5) > td');
      if (ratioElement != null && ratioElement2 != null) {
        _ratios.add(ratioElement.text);
        _ratios.add(ratioElement2.text);
      }
      else if(ratioElement == null && ratioElement2 != null){
        _ratios.add("-");
        _ratios.add(ratioElement2.text);
      }
      else if(ratioElement != null && ratioElement2 == null){
        _ratios.add(ratioElement.text);
        _ratios.add("-");
      }
      else {
        _ratios.add("-");
        _ratios.add("-");
      }
      if(ratioElement3 != null){
        _ratios.add(ratioElement3.text);
      }
    } else {
      _ratios.add("Failed to load page");
    }
    setState(() {
      controller = true;
    });
  }
}
