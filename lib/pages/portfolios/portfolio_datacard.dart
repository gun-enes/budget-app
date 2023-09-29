import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import '../../services/invest_provider.dart';
import '../../services/program_provider.dart';
class PortfolioDataCard extends StatefulWidget {
  const PortfolioDataCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final StockDataModel data;
  final int index;

  @override
  State<PortfolioDataCard> createState() => _PortfolioDataCardState();
}

class _PortfolioDataCardState extends State<PortfolioDataCard> {
  @override
  Widget build(BuildContext context) {
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    return ClipRRect(
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
                    backgroundColor: investProvider.returnPrice(widget.data.title) > widget.data.price ? Colors.greenAccent: Colors.redAccent,
                    child: investProvider.returnPrice(widget.data.title) > widget.data.price ? const Icon(Icons.keyboard_arrow_up_rounded):const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(widget.data.title.toUpperCase(), style: const TextStyle(fontSize: 20),),
                              /*Text("(%${programProvider.returnChange(widget.data.title)})", style: TextStyle(color: programProvider.returnChange(widget.data.title) < 0 ? Colors.red : programProvider.returnChange(widget.data.title) == 0 ? Colors.grey : Colors.green),)*/
                            ],
                          ),
                          Text("Adet: ${widget.data.amount.abs().toString()}"),
                          Text("Maliyet: ${widget.data.price.toStringAsFixed(2)}TL"),
                          //Text("${widget.data.price.toStringAsFixed(2)}TL")
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
                          Text((investProvider.returnPrice(widget.data.title)*widget.data.amount).toStringAsFixed(2), style: const TextStyle(fontSize: 20),),
                          investProvider.returnPrice(widget.data.title) > widget.data.price ?
                          Text("%${(100*((investProvider.returnPrice(widget.data.title)-widget.data.price)/widget.data.price)).toStringAsFixed(2)} (+${(investProvider.returnPrice(widget.data.title)*widget.data.amount-widget.data.amount*widget.data.price).toStringAsFixed(2)})", overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(color: Colors.green),):
                          Text("-%${(-100*((investProvider.returnPrice(widget.data.title)-widget.data.price)/widget.data.price)).toStringAsFixed(2)} (${(investProvider.returnPrice(widget.data.title)*widget.data.amount-widget.data.amount*widget.data.price).toStringAsFixed(2)})",overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(color: Colors.redAccent),),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Fiyat: ${(investProvider.returnPrice(widget.data.title)).toStringAsFixed(2)}",),
                              /*Text("(%${programProvider.returnChange(widget.data.title)})", style: TextStyle(color: programProvider.returnChange(widget.data.title) < 0 ? Colors.red : programProvider.returnChange(widget.data.title) == 0 ? Colors.grey : Colors.green),)*/
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
    );
  }
}
