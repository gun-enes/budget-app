import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/alltime/categories_datacard.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import '../../services/program_provider.dart';
import '../expenses/expense_datacard.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    List<ExpenseDataModel> exp = programProvider.getExpenseByMonth(programProvider.expenseList, DateTime.now());
    List<ExpenseDataModel> cats = programProvider.getExpenseByKind(exp);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bu ay"),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          PopupMenuButton<String>(
            clipBehavior: Clip.antiAlias,
          onSelected: (value) {
            if(value == 'Gelirleri göster'){
            }
            else if(value == 'Giderleri göster'){
            }

          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Gelirleri göster',
              child: ListTile(
                //leading: Icon(Icons.label),
                title: Text('Gelirleri göster'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Giderleri göster',
              child: ListTile(
                //leading: Icon(Icons.label),
                title: Text('Giderleri göster'),
              ),)
          ],
        )],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5,),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  itemCount: cats.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CategoriesDataCard(
                          data: cats[index],
                          index: index,
                        ),
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
