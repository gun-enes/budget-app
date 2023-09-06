import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/program_provider.dart';
import 'package:sql_project2/pages/stock_add/stock_popup.dart';

import 'stock_datacard.dart';
class Stocks extends StatefulWidget {
  const Stocks({Key? key}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("Hisse al/sat"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () =>
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => const StockPopUp()
            ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          programProvider.stockList.isEmpty
              ? Align(alignment: Alignment.center,
              child: Text("Gelirlerinizi buraya girin",
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),))
              : Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: programProvider.stockList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  int reverse = programProvider.stockList.length - 1 - index;
                  return StockDataCard(
                    data: programProvider.stockList[reverse],
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
