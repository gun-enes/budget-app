import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/portfolios/portfolio.dart';
import 'package:sql_project2/services/models/portfolio_datamodel.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import '../../services/program_provider.dart';
import '../../services/invest_provider.dart';
class AllPortfolioDataCard extends StatefulWidget {
  const AllPortfolioDataCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final PortfolioDataModel data;
  final int index;

  @override
  State<AllPortfolioDataCard> createState() => _AllPortfolioDataCardState();
}

class _AllPortfolioDataCardState extends State<AllPortfolioDataCard> {
  @override
  Widget build(BuildContext context) {
    InvestProvider programProvider = Provider.of<InvestProvider>(context);
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){
            },
            backgroundColor:const  Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (BuildContext context){
              programProvider.deletePortfolioList(widget.data);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Portfolio(
                portfolioTitle: widget.data.title
            )
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    12.0,8.0, 12.0,8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: programProvider.returnPortfolioProfit(widget.data.title) > 0? Colors.greenAccent: programProvider.returnPortfolioProfit(widget.data.title) == 0 ? Colors.blueGrey:Colors.redAccent,
                        child: programProvider.returnPortfolioProfit(widget.data.title) > 0 ? const Icon(Icons.keyboard_arrow_up_rounded):programProvider.returnPortfolioProfit(widget.data.title) == 0  ? const Icon(Icons.remove): const Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.data.title.toUpperCase(), style: const TextStyle(fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text("${(programProvider.returnPortfolioValue(widget.data.title)).toStringAsFixed(2)} TL", style: const TextStyle(fontSize: 20),),
                              Text("%${(100*programProvider.returnPortfolioProfit(widget.data.title)/(programProvider.returnPortfolioValue(widget.data.title) - programProvider.returnPortfolioProfit(widget.data.title))).toStringAsFixed(2)} (${programProvider.returnPortfolioProfit(widget.data.title).toStringAsFixed(2)})", style: TextStyle(color: programProvider.returnPortfolioProfit(widget.data.title)>0 ? Colors.green : Colors.red))
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
        ),
      ),
    );
  }
}
