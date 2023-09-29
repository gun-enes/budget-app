import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/expenses/add_income.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import '../../services/program_provider.dart';
import '../month/months.dart';
import '../navbars/navigation_drawer.dart';
import 'expense_datacard.dart';
import 'package:sql_project2/pages/expenses/add_expense.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    List<ExpenseDataModel> expenses = programProvider.expenseList;
    return Scaffold(
      //drawer: const NavDraw(),
      appBar: AppBar(
        title: Text("Gelir/Gider"),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [PopupMenuButton<String>(
          onSelected: (value) {
            if(value == 'Aylar'){
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => Months()),
              );
            }
            else if(value == 'Sadece gelirler'){
            }
            else if(value == 'Sadece giderler'){
            }

          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Aylar',
              child: ListTile(
                //leading: Icon(Icons.),
                title: Text("Aylar"),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Sadece gelirler',
              child: ListTile(
                //leading: Icon(Icons.label),
                title: Text('Sadece gelirler'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Sadece gelirler',
              child: ListTile(
                //leading: Icon(Icons.label),
                title: Text('Sadece gelirler'),
              ),)
          ],
        )],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        icon: Icons.add,
        spacing: 10,
        spaceBetweenChildren: 10,
        children: [
          SpeedDialChild(
            shape: CircleBorder(),
            child: Icon(Icons.add_circle_outline_sharp),
            label: 'Gelir',
            onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => const AddIncome()
            ),
          ),
          SpeedDialChild(
            shape: CircleBorder(),
            child: Icon(Icons.remove_circle_outline_sharp),
            label: 'Gider',
            onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => const AddExpense()
            ),
          )
        ],
      ),/*FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => const ShowPopUpHomePage()
        ),
        child: const Icon(Icons.add),
      ),*/
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5,),
          expenses.isEmpty
              ? Align(alignment: Alignment.center,
              child: Text("Giderlerinizi buraya girin",
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),))
              : Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  itemCount: expenses.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    int reverse = expenses.length - 1 - index;
                    return ExpenseDataCard(
                      data: expenses[reverse],
                      index: reverse,
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

/*StatefulBuilder(
    builder: (BuildContext context,StateSetter setState){
    return Container(
    height: 60,
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(10)
    ),
    child: DropdownButton2(
    underline: Container(
    height: 1,
    color: Colors.transparent,
    ),
    isExpanded: true,
    isDense: true,
    value: selection,
    buttonStyleData: ButtonStyleData(height: 70),
    items: kategoriler.map((option) {
    return DropdownMenuItem(
    value: option,
    child: Container(
    width:double.infinity,
    alignment:Alignment.centerLeft,
    padding: const EdgeInsets.fromLTRB(10.0,8.0,0,6.0),
    child: Text(option),
    ),
    );
    }
    ).toList(),
    selectedItemBuilder: (con) {
    return kategoriler.map((m) {
    return Text(m,);
    }).toList();
    },
    onChanged: (value) {
    setState(() {
    selection = value;
    });
    },
    ),
    );}
    ),*/
}
