import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import '../../services/program_provider.dart';

class AddExpense extends StatefulWidget {

  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final formGlobalKey = GlobalKey < FormState > ();

  final formGlobalKey2 = GlobalKey < FormState > ();

  TextEditingController titleController = TextEditingController();

  TextEditingController subtitleController = TextEditingController();

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
    "Eğlence",
    "Berber",
    "Tren",
    "Uçak",
    "Taksitler",
    "Nikotin",
    "Abonman",
    "Alkol",
    "Alışveriş",
    "Otobüs",
    "Diğer"
  ];

  String? selection;

  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
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
                        ..date = DateTime.now()
                        ..type = "Expense"
                        ..amount = int.parse(titleController.text);
                      programProvider.addToExpenseList(dataLocal);
                      titleController.clear();
                      subtitleController.clear();
                      selection = null;
                      Navigator.pop(context);
                      programProvider.showSnackBar(context, "Harcama eklendi");
                  }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Ekle",style: TextStyle(fontSize: 15,color: Colors.white),),
                  ),
                ),
              ),
            ],
          );
  }
}
