import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import '../../services/program_provider.dart';

class AddIncome extends StatefulWidget {

  const AddIncome({Key? key}) : super(key: key);

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final formGlobalKey = GlobalKey < FormState > ();

  TextEditingController titleController = TextEditingController();

  TextEditingController subtitleController = TextEditingController();

  int currentIndex = 0;

  List<String> kategoriler = [
    "Baba",
    "Cashback",
    "Borç",
    "Maaş",
    "Borsa",
    "Burs",
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
                          ..type = "Income"
                          ..date = DateTime.now()
                          ..amount = int.parse(titleController.text);
                        programProvider.addToExpenseList(dataLocal);
                        titleController.clear();
                        subtitleController.clear();
                        selection = "Baba";
                        Navigator.pop(context);
                        programProvider.showSnackBar(context, "Gelir eklendi");
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
