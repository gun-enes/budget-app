import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import '../../services/invest_provider.dart';
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
    InvestProvider programProvider = Provider.of<InvestProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          //margin: const EdgeInsets.only(bottom: 6.0), //Same
          child: Slidable(

            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context){
                    showSnackBar(context, "Silme işlemi başarılı",widget.data);
                    programProvider.deleteFromStockList(widget.data);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Sil',
                ),
                SlidableAction(
                  onPressed: (BuildContext context){
                  },
                  backgroundColor:const  Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Düzenle',
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
                        color: widget.data.amount >= 0 ? Colors.greenAccent: Colors.redAccent,
                        width: 60,
                        height: 70,
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(dayDate,style: const TextStyle(fontSize: 18),),
                                Text(trdate, style: const TextStyle(fontSize: 18),)
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("₺${(widget.data.amount*widget.data.price).toStringAsFixed(2)}", style: const TextStyle(fontSize: 16),),
                          Text("${widget.data.amount.abs().toString()} adet")
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

void showSnackBar(BuildContext context, String text, StockDataModel data) {
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
            investProvider.addToStockList(data);
          },
        )

    ),
  );
}
