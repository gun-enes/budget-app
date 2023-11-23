import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/models/expense_data_model.dart';
import '../../services/program_provider.dart';


class EditExpense extends StatefulWidget {
  final ExpenseDataModel expenseDataModel;
  const EditExpense({required this.expenseDataModel,Key? key}) : super(key: key);

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  final formGlobalKey = GlobalKey < FormState > ();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  DateTime now = DateTime.now();
  List<String> kategoriler = [
    "Market",
    "Yemek",
    "Cafe",
    "Para Çekme",
    "Borç",
    "Su",
    "Taksi",
    "Giyim",
    "Tren",
    "Taksitler",
    "Nikotin",
    "Abonman",
    "Alkol",
    "Alışveriş",
    "Diğer"
  ];

  String? selection;
  @override
  void initState(){
    super.initState();
    selection = widget.expenseDataModel.title;
    titleController.text = widget.expenseDataModel.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    titleController.text = widget.expenseDataModel.amount.toString();
    subtitleController.text = widget.expenseDataModel.title;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(14),
      content: SizedBox(
        height: 135,
        child: Column(
          children: [
            Form(
              key: formGlobalKey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bu alan boş bırakılamaz!';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: titleController,
                decoration: const InputDecoration(
                    isDense: true,
                    hoverColor: Colors.black,
                    filled: true,
                    //fillColor: Colors.purple,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 10),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Miktar"
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownSearch<String>(
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  isDense: true,
                  hoverColor: Colors.black,
                  filled: true,
                  label: Text("Detay"),
                  //fillColor: Colors.purple,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 10),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              popupProps: const PopupProps.dialog(
                showSelectedItems: true,
              ),
              items: kategoriler,
              onChanged: (value) {
                subtitleController.text = value!;
              },
            )
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
            ),
            onPressed: () {
              if (formGlobalKey.currentState!.validate()) {
                final dataLocal = ExpenseDataModel()
                  ..title = subtitleController.text
                  ..type = "Income"
                  ..date = widget.expenseDataModel.date
                  ..amount = int.parse(titleController.text);
                programProvider.updateExpense(dataLocal,widget.expenseDataModel);
                titleController.clear();
                subtitleController.clear();
                selection = "Baba";
                Navigator.pop(context);
                programProvider.showSnackBar(context, "Gelir eklendi");
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Düzenle",style: TextStyle(fontSize: 15,color: Colors.white),),
            ),
          ),
        ),
      ],
    );
  }
}