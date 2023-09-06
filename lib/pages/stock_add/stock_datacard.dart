import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/income_data_model.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';

import '../../services/program_provider.dart';
class StockDataCard extends StatefulWidget {
  const StockDataCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final StockDataModel data;
  final int index;

  @override
  State<StockDataCard> createState() => _StockDataCardState();
}

class _StockDataCardState extends State<StockDataCard> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }
  @override
  Widget build(BuildContext context) {
    String dayDate = DateFormat.d('tr').format(widget.data.date);
    String trdate = DateFormat.MMM('tr').format(widget.data.date);
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          //margin: const EdgeInsets.only(bottom: 6.0), //Same
          child: Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context){
                    programProvider.deleteFromStockList(widget.data);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (BuildContext context){},
                  backgroundColor: const Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),

            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context){
                    programProvider.deleteFromStockList(widget.data);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (BuildContext context){
                  },
                  backgroundColor:const  Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Edit',
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  12.0,8.0, 12.0,8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: <Widget>[
                    Container(
                        color: widget.data.amount >= 0 ? Colors.green: Colors.red,
                        width: 60,
                        height: 70,
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(dayDate,style: TextStyle(fontSize: 18),),
                                Text(trdate, style: TextStyle(fontSize: 18),)
                              ],
                            )
                        )
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.data.title.toUpperCase(), style: const TextStyle(fontSize: 16),),
                          //Text(trdate),
                          widget.data.amount > 0 ?
                          Text("Alım fiyatı ${widget.data.price.toStringAsFixed(2)}₺"):
                          Text("Satım fiyatı ${widget.data.price.toStringAsFixed(2)}₺"),
                          Text("${widget.data.amount.abs().toString()} adet")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("₺${(widget.data.amount*widget.data.price).toStringAsFixed(2)}", style: const TextStyle(fontSize: 16),),
                          Text(widget.data.portfolio, style: const TextStyle(fontSize: 16),)
                        ],
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
