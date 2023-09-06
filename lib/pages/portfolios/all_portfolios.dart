import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/hisseler.dart';
import 'package:sql_project2/pages/portfolios/all_portfolios_datacard.dart';
import 'package:sql_project2/pages/portfolios/portfolio.dart';
import 'package:sql_project2/services/models/portfolio_datamodel.dart';
import '../../services/program_provider.dart';
import '../expenses/expense_datacard.dart';
import 'package:sql_project2/pages/expenses/showPopupExpenses.dart';

import '../stock_add/stocks.dart';


class AllPortfolios extends StatefulWidget {
  const AllPortfolios({Key? key}) : super(key: key);

  @override
  State<AllPortfolios> createState() => _AllPortfoliosState();
}

class _AllPortfoliosState extends State<AllPortfolios> {
  int currentIndex = 0;
  final formGlobalKey = GlobalKey < FormState > ();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Portföy"),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          //IconButton(onPressed: onPressed, icon: icon)
          PopupMenuButton<String>(
            onSelected: (value) {
              if(value == 'BIST'){
                Navigator.push(
                  context,MaterialPageRoute(builder: (context) => Hisseler()),
                );
              }
              else if(value == 'Hisse'){
                Navigator.push(
                  context,MaterialPageRoute(builder: (context) => Stocks()),
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
                  title: Text('Hisse al/sat'),
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
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
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Portfolyo adı giriniz",
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
                    final dataLocal = PortfolioDataModel()..title = titleController.text;
                    programProvider.addToPortfolioList(dataLocal);
                    titleController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Center(child: Text("Ekle")),
              ),
            ],
          )
      ),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8,),
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
                                Text("${(programProvider.returnValue()).toStringAsFixed(2)}", style: const TextStyle(fontSize: 20),),
                                programProvider.returnProfit() >= 0 ?
                                Text(" %${(100*programProvider.returnProfit()/(programProvider.returnValue() - programProvider.returnProfit())).toStringAsFixed(2)} (+${programProvider.returnProfit().toStringAsFixed(2)})",style: TextStyle(fontSize: 20, color: programProvider.returnProfit() > 0 ? Colors.green: Colors.red))
                                    :
                                Text(" -%${(-100*programProvider.returnProfit()/(programProvider.returnValue() - programProvider.returnProfit())).toStringAsFixed(2)} (-${programProvider.returnProfit().toStringAsFixed(2)})",style: TextStyle(fontSize: 20, color: programProvider.returnProfit() > 0 ? Colors.green: Colors.red))

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
                      itemCount: programProvider.portfolioList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            AllPortfolioDataCard(data: programProvider.portfolioList[index], index: index),
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
