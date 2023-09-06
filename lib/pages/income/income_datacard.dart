import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/income_data_model.dart';

import '../../services/program_provider.dart';
class IncomeDataCard extends StatefulWidget {
  const IncomeDataCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final IncomeDataModel data;
  final int index;

  @override
  State<IncomeDataCard> createState() => _IncomeDataCardState();
}

class _IncomeDataCardState extends State<IncomeDataCard> {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        //margin: const EdgeInsets.only(bottom: 6.0), //Same
        decoration:  BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow:const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        height: 90,
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context){
                  programProvider.deleteIncome(widget.data);
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
                  programProvider.deleteIncome(widget.data);
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
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.data.title.toUpperCase(), style: const TextStyle(fontSize: 16),),
                        Text(trdate),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("₺${(widget.data.amount).toString()}", style: const TextStyle(fontSize: 16),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    /*Padding(
      padding: const EdgeInsets.fromLTRB(2.0,6.0,2.0,6.0),
      child: Column(
        children: [
          ListTile(
            style: ListTileStyle.list,
            title: Text(widget.data.title.toUpperCase()),
            subtitle: Text(trdate),
            leading: IconButton(
              onPressed: () {
                programProvider.deleteIncome(widget.data);
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
            trailing: Text("₺${(widget.data.amount).toString()}", style: const TextStyle(fontSize: 16),),
            dense: false,
          ),
          Divider(
            color: Colors.grey[500],
            indent: 30,
            endIndent: 30,
          )
        ],
      ),
    );*/
  }
}
