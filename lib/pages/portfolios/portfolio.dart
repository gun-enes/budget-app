import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import 'package:sql_project2/services/program_provider.dart';
import 'package:sql_project2/pages/portfolios/portfolio_datacard.dart';

class Portfolio extends StatefulWidget {
  final String portfolioTitle;
  const Portfolio({Key? key, required this.portfolioTitle}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {

  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    List<StockDataModel> stockList = programProvider.getStocksByPortfolio(widget.portfolioTitle);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.portfolioTitle.toUpperCase()),
        //backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Portföy Değeri",style: TextStyle(fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${(programProvider.returnPortfolioValue(widget.portfolioTitle)).toStringAsFixed(2)}", style: const TextStyle(fontSize: 20),),
                              Text(" %${(100*programProvider.returnPortfolioProfit(widget.portfolioTitle)/(programProvider.returnPortfolioValue(widget.portfolioTitle) - programProvider.returnPortfolioProfit(widget.portfolioTitle))).toStringAsFixed(2)} (+${programProvider.returnPortfolioProfit(widget.portfolioTitle).toStringAsFixed(2)})",style: TextStyle(fontSize: 20, color: programProvider.returnPortfolioProfit(widget.portfolioTitle) > 0 ? Colors.green: Colors.red))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: RefreshIndicator(
                onRefresh: programProvider.getData,
                child: ListView.builder(
                  itemCount: stockList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    int reverse = stockList.length - 1 - index;
                    return Column(
                      children: [
                        PortfolioDataCard(
                          data: stockList[reverse],
                          index: reverse,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}