import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/advise/stockinfo.dart';
import 'package:sql_project2/services/invest_provider.dart';
import 'package:sql_project2/services/models/advice_datamodel.dart';
import 'package:sql_project2/services/models/historical_stock_info.dart';
class AdviceDatacard extends StatefulWidget {
  final StockSuggestion data;
  const AdviceDatacard({Key? key, required this.data, required int index}) : super(key: key);

  @override
  State<AdviceDatacard> createState() => _AdviceDatacardState();
}

class _AdviceDatacardState extends State<AdviceDatacard> {
  @override
  Widget build(BuildContext context) {
    InvestProvider programProvider = Provider.of<InvestProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: GestureDetector(
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StockInfo(code: widget.data.symbol,)));
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
                      backgroundColor: widget.data.suggestion == "GÜÇLÜ AL" ? Colors.green: widget.data.suggestion == "AL" ? Colors.greenAccent: widget.data.suggestion == "SAT" ? Colors.redAccent: widget.data.suggestion == "GÜÇLÜ SAT" ? Colors.red: Colors.blueGrey,

                      child: Text(widget.data.suggestion, style: const TextStyle(fontSize: 12)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.data.symbol.toUpperCase(), style: const TextStyle(fontSize: 20),),
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
                            Text("${(programProvider.returnPrice(widget.data.symbol)).toStringAsFixed(2)} TL", style: const TextStyle(fontSize: 20),),
                            Text("%${programProvider.returnChange(widget.data.symbol)}", style: TextStyle(color: programProvider.returnChange(widget.data.symbol)>0 ? Colors.green : Colors.red))
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
    );
  }
}
