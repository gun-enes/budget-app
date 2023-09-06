import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import 'package:sql_project2/services/program_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sql_project2/pages/expenses/showPopUpExpensesUpdate.dart';

class CategoriesDataCard extends StatefulWidget {
  const CategoriesDataCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final ExpenseDataModel data;
  final int index;

  @override
  State<CategoriesDataCard> createState() => _CategoriesDataCardState();
}

class _CategoriesDataCardState extends State<CategoriesDataCard> {
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
    //List<ExpenseDataModel> expenses = programProvider.
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
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
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data.title.toUpperCase(), style: const TextStyle(fontSize: 16),),
                        ),
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
    );
  }
}
