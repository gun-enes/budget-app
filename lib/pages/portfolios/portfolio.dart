import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import 'package:sql_project2/pages/portfolios/portfolio_datacard.dart';

import '../../services/invest_provider.dart';
import '../stock_add/stocks.dart';

class Portfolio extends StatefulWidget {
  final String portfolioTitle;
  const Portfolio({Key? key, required this.portfolioTitle}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {

  @override
  Widget build(BuildContext context) {
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    List<StockDataModel> stockList = investProvider.getStocksByPortfolio(widget.portfolioTitle);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Nakit",style: TextStyle(fontSize: 16),),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Portföy Değeri",style: TextStyle(fontSize: 16),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${(investProvider.returnPortfolioValue(widget.portfolioTitle)).toStringAsFixed(2)}", style: const TextStyle(fontSize: 20),),
                          Text(" %${(100*investProvider.returnPortfolioProfit(widget.portfolioTitle)/(investProvider.returnPortfolioValue(widget.portfolioTitle) - investProvider.returnPortfolioProfit(widget.portfolioTitle))).toStringAsFixed(2)} (+${investProvider.returnPortfolioProfit(widget.portfolioTitle).toStringAsFixed(2)})",style: TextStyle(fontSize: 20, color: investProvider.returnPortfolioProfit(widget.portfolioTitle) > 0 ? Colors.green: Colors.red))
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                        onPressed:  (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Stocks(portfolioTitle: widget.portfolioTitle,)),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Hisse al/sat",style: TextStyle(fontSize: 16,color: Colors.white),),
                            ],
                          ),),
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
                onRefresh: investProvider.getData,
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