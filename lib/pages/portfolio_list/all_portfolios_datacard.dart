import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/portfolio_list/update_portfolio.dart';
import 'package:sql_project2/pages/portfolios/portfolio.dart';
import 'package:sql_project2/services/models/portfolio_datamodel.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import '../../services/invest_provider.dart';
import '../../services/program_provider.dart';
import 'add_portfolio_popup.dart';
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
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => UpdatePortfolio(widget.data),
              ),
            backgroundColor:const  Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Düzenle',
          ),
          SlidableAction(
            onPressed: (BuildContext context){
              investProvider.deletePortfolioList(widget.data);
              ShowSnackBar(context, "Silme işlemi başarılı",widget.data);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Sil',
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
                        backgroundColor: investProvider.returnPortfolioProfit(widget.data.title) > 0? Colors.greenAccent: investProvider.returnPortfolioProfit(widget.data.title) == 0 ? Colors.blueGrey:Colors.redAccent,
                        child: investProvider.returnPortfolioProfit(widget.data.title) > 0 ? const Icon(Icons.keyboard_arrow_up_rounded):investProvider.returnPortfolioProfit(widget.data.title) == 0  ? const Icon(Icons.remove): const Icon(Icons.keyboard_arrow_down_rounded),
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
                              Text("${(investProvider.returnPortfolioValue(widget.data.title)+investProvider.returnCash(widget.data.title)).toStringAsFixed(2)} TL", style: const TextStyle(fontSize: 20),),
                              Text("%${(100*investProvider.returnPortfolioProfit(widget.data.title)/(investProvider.returnPortfolioValue(widget.data.title) - investProvider.returnPortfolioProfit(widget.data.title))).toStringAsFixed(2)} (${investProvider.returnPortfolioProfit(widget.data.title).toStringAsFixed(2)})", style: TextStyle(color: investProvider.returnPortfolioProfit(widget.data.title)>0 ? Colors.green : Colors.red))
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
void ShowSnackBar(BuildContext context, String text, PortfolioDataModel data) {
  InvestProvider investProvider = Provider.of<InvestProvider>(context, listen: false);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      backgroundColor: Colors.white,
      content: Text(text,style: TextStyle(color: Colors.blue),),
      duration: const Duration(seconds: 8),
      animation: CurvedAnimation(
        parent: const AlwaysStoppedAnimation<double>(1),
        curve: Curves.fastOutSlowIn,
      ),
      action: SnackBarAction(
        textColor: Colors.red,
        label: 'Geri Al',
        onPressed: () {
          investProvider.addToPortfolioList(data);
        },
      )

    ),
  );
}
