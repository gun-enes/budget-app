import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/daily_data_model.dart';
import 'package:sql_project2/services/program_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

class DataCard2 extends StatefulWidget {
  const DataCard2({
    Key? key,
    required this.data,
    required this.index,
    required this.limit,
  }) : super(key: key);
  final DailyDataModel data;
  final int index;
  final int limit;
  @override
  State<DataCard2> createState() => _DataCard2State();
}

class _DataCard2State extends State<DataCard2> {
  late DateFormat trvakti;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    trvakti = DateFormat.MMMEd('tr');
  }
  @override
  Widget build(BuildContext context) {
    String trdate = trvakti.format(widget.data.date);
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    return Column(
      children: [
        widget.limit == 1  ?
        Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 SizedBox(width: 30,),
                Row(
                  children:  [
                    Icon(Icons.delete,color: Colors.white,),
                    Text("Sil",style: TextStyle(fontSize: 16, color: Colors.white),)
                  ],
                ),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //const SizedBox(width: 280,),
                Row(
                  children: [
                    Text("Sil",style: TextStyle(fontSize: 16, color: Colors.white),),
                    Icon(Icons.delete,color: Colors.white,)
                  ],
                ),
                SizedBox(width: 30,),
              ],
            ),
          ),
          onDismissed: (DismissDirection direction) {
            programProvider.deleteDay(widget.data);
          },
          child: Column(
            children: [
              ListTile(
                style: ListTileStyle.list,
                subtitle: Text(trdate),
                title: Text("${widget.data.amount},00 TL"),
                leading: widget.data.amount < widget.data.limit ?
                      CircleAvatar(radius: 30, backgroundColor: Colors.green,child: Text("${(-widget.data.amount+widget.data.limit).toString()} TL", style: const TextStyle(fontSize: 14,color: Colors.white),)) :
                      CircleAvatar(radius: 30,backgroundColor: Colors.red,child: Text("${(widget.data.amount-widget.data.limit).toString()} TL", style: const TextStyle(fontSize: 14,color: Colors.white),)),
                dense: false,
              ),
              Divider(
                color: Colors.grey[300],
                indent: 30,
                endIndent: 30,
              ),
            ],
          ),
        ):
        Column(
          children: [
            ListTile(
              style: ListTileStyle.list,
              subtitle: Text(trdate),
              title: Text("${widget.data.amount},00 TL"),
              leading: widget.data.amount < widget.data.limit ?
              CircleAvatar(radius: 30, backgroundColor: Colors.green,child: Text("${(-widget.data.amount+widget.data.limit).toString()} TL", style: const TextStyle(fontSize: 14,color: Colors.white),)) :
              CircleAvatar(radius: 30,backgroundColor: Colors.red,child: Text("${(widget.data.amount-widget.data.limit).toString()} TL", style: const TextStyle(fontSize: 14,color: Colors.white),)),
              dense: false,
            ),
            Divider(
              color: Colors.grey[300],
              indent: 30,
              endIndent: 30,
            ),
          ],
        ),




      ],
    );
  }
}
