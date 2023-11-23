import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import '../../services/program_provider.dart';

class ShowPopUpHomePage extends StatefulWidget {

  const ShowPopUpHomePage({Key? key}) : super(key: key);

  @override
  State<ShowPopUpHomePage> createState() => _ShowPopUpHomePageState();
}

class _ShowPopUpHomePageState extends State<ShowPopUpHomePage> {
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
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
          return AlertDialog(
            contentPadding: const EdgeInsets.all(14),
            content: SizedBox(
              height: 162,
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          labelText: "Miktar"
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: DropdownButtonFormField2(
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none
                            ),
                            hint: const Text("Detay"),
                            isExpanded: true,
                            isDense: true,
                            value: selection,
                            buttonStyleData: const ButtonStyleData(height: 70),
                            items: kategoriler.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 8.0, 0, 6.0),
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
                                selection = value!;
                              });
                            },
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                    if (formGlobalKey.currentState!.validate()) {
                      if (selection != null) {
                        final dataLocal = ExpenseDataModel()
                          ..title = selection!
                          ..date = DateTime.now()
                          ..type = "Expense"
                          ..amount = int.parse(titleController.text);
                        programProvider.addToExpenseList(dataLocal);
                        titleController.clear();
                        subtitleController.clear();
                        selection = null;
                        Navigator.pop(context);
                      }
                    }
                },
                child: const Center(child: Text("Ekle")),
              ),
            ],
          );
  }
}
