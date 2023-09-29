import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/advise/advise_datacard.dart';
import 'package:sql_project2/services/invest_provider.dart';
import 'package:sql_project2/services/models/advice_datamodel.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import 'package:sql_project2/services/prediction_provider.dart';

import '../../services/models/historical_stock_info.dart';
import '../../services/models/watchlist.dart';
import '../portfolios/watchlist_datacard.dart';

class AdviceList extends StatefulWidget {
  const AdviceList({Key? key}) : super(key: key);

  @override
  State<AdviceList> createState() => _AdviceListState();
}

class _AdviceListState extends State<AdviceList> {
  @override
  Widget build(BuildContext context) {
    PredictionProvider predictionProvider = Provider.of<PredictionProvider>(context);
    List<StockSuggestion> adviceList = predictionProvider.adviceList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öneriler"),
      ),
      body: !predictionProvider.controller ?
      Column(
mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 20),
          Text("${predictionProvider.stockCount}/${predictionProvider.stockHistory.length} hisse işlendi")
        ],
      ) : Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  itemCount: adviceList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        AdviceDatacard(data: adviceList[index], index: index),
                      ],
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
