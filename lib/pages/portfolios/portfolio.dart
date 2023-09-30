import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/cash.dart';
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
    final formGlobalKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    List<StockDataModel> stockList = investProvider.getStocksByPortfolio(widget.portfolioTitle);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: formGlobalKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Bu alan boş bırakılamaz!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: "Nakit Miktarı",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          CashDataModel cashDataModel = CashDataModel()..portfolio= widget.portfolioTitle..cash = double.parse(titleController.text.toString());
                          investProvider.addToCashList(cashDataModel);
                          titleController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Center(child: Text("Onayla")),
                    ),
                  ],
                )
            ),
            icon: Icon(Icons.add)),],
        title: Text(widget.portfolioTitle.toUpperCase()),
        //backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 500,
              child: Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [

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
                            Text("${(investProvider.returnPortfolioValue(widget.portfolioTitle)+investProvider.returnCash(widget.portfolioTitle)).toStringAsFixed(2)}", style: const TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Hisse Değeri:",style: TextStyle(fontSize: 16),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${(investProvider.returnPortfolioValue(widget.portfolioTitle)).toStringAsFixed(2)}", style: const TextStyle(fontSize: 20),),
                                Text(" %${(100*investProvider.returnPortfolioProfit(widget.portfolioTitle)/(investProvider.returnPortfolioValue(widget.portfolioTitle) - investProvider.returnPortfolioProfit(widget.portfolioTitle))).toStringAsFixed(2)}(${investProvider.returnPortfolioProfit(widget.portfolioTitle).toStringAsFixed(2)})",style: TextStyle(fontSize: 18, color: investProvider.returnPortfolioProfit(widget.portfolioTitle) > 0 ? Colors.green: Colors.red))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Dolar Bazlı:",style: TextStyle(fontSize: 16),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(" %${(100*investProvider.returnPortfolioProfitDollar(widget.portfolioTitle)/(investProvider.returnPortfolioValueDollar(widget.portfolioTitle) - investProvider.returnPortfolioProfitDollar(widget.portfolioTitle))).toStringAsFixed(2)}",style: TextStyle(fontSize: 18, color: investProvider.returnPortfolioProfitDollar(widget.portfolioTitle) > 0 ? Colors.green: Colors.red))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Borsa Bazlı:",style: TextStyle(fontSize: 16),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(" %${(100*investProvider.returnPortfolioProfitBist(widget.portfolioTitle)/(investProvider.returnPortfolioValueBist(widget.portfolioTitle) - investProvider.returnPortfolioProfitBist(widget.portfolioTitle))).toStringAsFixed(2)}",style: TextStyle(fontSize: 18, color: investProvider.returnPortfolioProfitBist(widget.portfolioTitle) > 0 ? Colors.green: Colors.red))
                              ],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          maximumSize: MaterialStateProperty.all<Size>(const Size(200,50)),
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
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: RefreshIndicator(
                onRefresh: investProvider.getData,
                child: ListView.builder(
                  itemCount: stockList.length+1,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    int reverse = stockList.length  - index;
                    return Column(
                      children: [
                        index == 0 ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0,14.0, 12.0,14.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Row(
                                    children: <Widget>[
                                      const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.green,
                                        child: Icon(Icons.attach_money)
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Row(
                                                children: [
                                                  Text("Nakit", style: const TextStyle(fontSize: 20),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 16.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("${investProvider.returnCash(widget.portfolioTitle)}" ,style: const TextStyle(fontSize: 20),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):
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