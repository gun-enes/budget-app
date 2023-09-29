import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import 'package:sql_project2/services/program_provider.dart';
import 'package:sql_project2/pages/stock_add/stock_popup.dart';

import '../../services/invest_provider.dart';
import 'stock_datacard.dart';
class Stocks extends StatefulWidget {
  final String portfolioTitle;
  const Stocks({Key? key, required this.portfolioTitle}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  @override
  Widget build(BuildContext context) {
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    List<StockDataModel> stockList = investProvider.getStockHistoryByPortfolio(widget.portfolioTitle);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
            investProvider.getData();
          },
        ),
        scrolledUnderElevation: 0,
        title: const Text("Hisse al/sat"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () =>
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => StockPopUp(title: widget.portfolioTitle,)
            ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          stockList.isEmpty
              ? Align(alignment: Alignment.center,
              child: Text("Gelirlerinizi buraya girin",
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),))
              : Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: stockList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  int reverse = stockList.length - 1 - index;
                  return StockDataCard(
                    data: stockList[reverse],
                    index: reverse,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
