import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import 'package:sql_project2/services/program_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sql_project2/pages/expenses/showPopUpExpensesUpdate.dart';

class ExpenseDataCard extends StatefulWidget {
  const ExpenseDataCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final ExpenseDataModel data;
  final int index;

  @override
  State<ExpenseDataCard> createState() => _ExpenseDataCardState();
}

class _ExpenseDataCardState extends State<ExpenseDataCard> {
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
            child: Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context){
                    programProvider.deleteExpense(widget.data);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (BuildContext context) => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => ShowPopUpHomePageUpdate(expenseDataModel: widget.data,)
                    ),
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
                    programProvider.deleteExpense(widget.data);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (BuildContext context)=> showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => ShowPopUpHomePageUpdate(expenseDataModel: widget.data,)
                  ),
                  backgroundColor: const Color(0xFF0392CF),
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
                        color: Colors.blue,
                        width: 60,
                        height: 70,
                        child: programProvider.iconExpense(widget.data)
                      ),
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
                        child: widget.data.type == "Expense" ? Text( "-${(widget.data.amount).toString()},00 TL", style: TextStyle(fontSize: 16, color: Colors.red.shade400),):
                          Text("${(widget.data.amount).toString()},00 TL" ,style: const TextStyle(fontSize: 16),)
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
