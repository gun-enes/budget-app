import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/alltime/categories_datacard.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import '../../services/program_provider.dart';

class ExpensesByMonth extends StatefulWidget {
  final DateTime date;
  const ExpensesByMonth({Key? key, required this.date}) : super(key: key);
  @override
  State<ExpensesByMonth> createState() => _ExpensesByMonthState();
}

class _ExpensesByMonthState extends State<ExpensesByMonth> {
  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    List<ExpenseDataModel> exp = programProvider.getExpenseByMonth(programProvider.expenseList, widget.date);
    List<ExpenseDataModel> expenses = programProvider.getExpenseByKind(exp);
    return Scaffold(
      appBar: AppBar(
        title: Text("${DateFormat.yMMMM("tr_TR").format(widget.date)}"),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  itemCount: expenses.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CategoriesDataCard(
                          data: expenses[index],
                          index: index,
                        ),
                        const SizedBox(height: 5,)
                      ],
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
