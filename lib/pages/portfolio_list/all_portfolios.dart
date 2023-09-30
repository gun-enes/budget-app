import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/hisseler.dart';
import 'package:sql_project2/pages/advise/advicelist.dart';
import 'package:sql_project2/pages/portfolios/portfolio.dart';
import 'package:sql_project2/pages/portfolios/watchlist.dart';
import 'package:sql_project2/services/invest_provider.dart';
import 'package:sql_project2/services/prediction_provider.dart';
import '../navbars/navigation_drawer.dart';
import 'add_portfolio_popup.dart';
import 'all_portfolios_datacard.dart';


class AllPortfolios extends StatefulWidget {
  const AllPortfolios({Key? key}) : super(key: key);

  @override
  State<AllPortfolios> createState() => _AllPortfoliosState();
}

class _AllPortfoliosState extends State<AllPortfolios> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    PredictionProvider predic = Provider.of<PredictionProvider>(context);
    return Scaffold(
      //drawer: const NavDraw(),
      appBar: AppBar(
        title: const Text("Portföy"),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => const AddPortfolio(),
            ),
              icon: Icon(Icons.add)),
          PopupMenuButton<String>(
            onSelected: (value) {
              if(value == 'BIST'){
                Navigator.push(
                  context,MaterialPageRoute(builder: (context) => Hisseler()),
                );
              }
              else if(value == 'Hisse'){
                Navigator.push(
                  context,MaterialPageRoute(builder: (context) => const AdviceList()),
                );
                predic.getRatios();
              }
              else if(value == 'Takip'){
                Navigator.push(
                  context,MaterialPageRoute(builder: (context) => const WatchList()),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'BIST',
                child: ListTile(
                  //leading: Icon(Icons.),
                  title: Text("Bist'e gir"),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Hisse',
                child: ListTile(
                  //leading: Icon(Icons.label),
                  title: Text('Önerilen Hisseler'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Takip',
                child: ListTile(
                  //leading: Icon(Icons.label),
                  title: Text('Takip Listesi'),
                ),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8,),
            GestureDetector(
              onTap: (){
                investProvider.getBIST();
                investProvider.getDollar();
                investProvider.watchListCreator();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const 
                  Portfolio(portfolioTitle: "portfoliodatamodelxyz")),
                );
              },
              child: Padding(
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: Text("Portföy Değeri",style: TextStyle(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${(investProvider.returnValue()+ investProvider.returnTotalCash()).toStringAsFixed(2)}", style: const TextStyle(fontSize: 20),),
                                  investProvider.returnProfit() >= 0 ?
                                  Text(" %${(100*investProvider.returnProfit()/(investProvider.returnValue() - investProvider.returnProfit())).toStringAsFixed(2)} (+${investProvider.returnProfit().toStringAsFixed(2)})",style: TextStyle(fontSize: 20, color: investProvider.returnProfit() > 0 ? Colors.green: Colors.red))
                                      :
                                  Text(" %${(-100*investProvider.returnProfit()/(investProvider.returnValue() - investProvider.returnProfit())).toStringAsFixed(2)} (${investProvider.returnProfit().toStringAsFixed(2)})",style: TextStyle(fontSize: 20, color: investProvider.returnProfit() > 0 ? Colors.green: Colors.red))

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
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: RefreshIndicator(
                  onRefresh: investProvider.getData,
                  child: ListView.builder(
                      itemCount: investProvider.portfolioList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            AllPortfolioDataCard(data: investProvider.portfolioList[index], index: index),
                          ],
                        );
                      }
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
