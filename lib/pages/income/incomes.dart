import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/program_provider.dart';
import 'income_datacard.dart';
import '../expenses/add_income.dart';

class Incomes extends StatefulWidget {
  const Incomes({Key? key}) : super(key: key);

  @override
  State<Incomes> createState() => _IncomesState();
}

class _IncomesState extends State<Incomes> {

  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () =>
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AddIncome()
            ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          programProvider.incomeList.isEmpty
              ? Align(alignment: Alignment.center,
              child: Text("Gelirlerinizi buraya girin",
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),))
              : Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: programProvider.incomeList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  int reverse = programProvider.incomeList.length - 1 - index;
                  return IncomeDataCard(
                    data: programProvider.incomeList[reverse],
                    index: reverse,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}