import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/advise/stockinfo.dart';
import 'package:sql_project2/services/models/watchlist.dart';
import '../../services/invest_provider.dart';
class WatchListDataCard extends StatefulWidget {
  const WatchListDataCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final WatchListDataModel data;
  final int index;

  @override
  State<WatchListDataCard> createState() => _WatchListDataCardState();
}

class _WatchListDataCardState extends State<WatchListDataCard> {
  @override
  Widget build(BuildContext context) {
    InvestProvider programProvider = Provider.of<InvestProvider>(context);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){
              showSnackBar(context, "Silme işlemi başarılı",widget.data);
              programProvider.deleteWatchList(widget.data);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Sil',
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: GestureDetector(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => StockInfo(code: widget.data.title,)));
            },
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
                        backgroundColor: programProvider.returnChange(widget.data.title) > 0? Colors.greenAccent: programProvider.returnChange(widget.data.title) == 0 ? Colors.blueGrey:Colors.redAccent,
                        child: programProvider.returnChange(widget.data.title) > 0 ? const Icon(Icons.keyboard_arrow_up_rounded):programProvider.returnChange(widget.data.title) == 0  ? const Icon(Icons.remove): const Icon(Icons.keyboard_arrow_down_rounded),
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
                              Text("${(programProvider.returnPrice(widget.data.title)).toStringAsFixed(2)} TL", style: const TextStyle(fontSize: 20),),
                              Text("%${programProvider.returnChange(widget.data.title)}", style: TextStyle(color: programProvider.returnChange(widget.data.title)>0 ? Colors.green : Colors.red))
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
void showSnackBar(BuildContext context, String text, WatchListDataModel data) {
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
        content: Text(text,style: const TextStyle(color: Colors.blue),),
        duration: const Duration(seconds: 8),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation<double>(1),
          curve: Curves.fastOutSlowIn,
        ),
        action: SnackBarAction(
          textColor: Colors.red,
          label: 'Geri Al',
          onPressed: () {
            investProvider.addToWatchList(data);
          },
        )

    ),
  );
}
