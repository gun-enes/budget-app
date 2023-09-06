import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';

import '../../services/models/income_data_model.dart';
import '../../services/program_provider.dart';

class ShowPopUpGelirPage extends StatefulWidget {

  const ShowPopUpGelirPage({Key? key}) : super(key: key);

  @override
  State<ShowPopUpGelirPage> createState() => _ShowPopUpGelirPageState();
}

class _ShowPopUpGelirPageState extends State<ShowPopUpGelirPage> {
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
              height: 150,
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
                          child: DropdownButton2(
                            hint: const Text("Detay"),
                            underline: Container(
                              height: 1,
                              color: Colors.transparent,
                            ),
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
                onPressed: (){
                  if (formGlobalKey.currentState!.validate()) {
                    if (selection != null) {
                    final dataLocal = ExpenseDataModel()
                      ..title = selection!
                      ..type = "Income"
                      ..date = DateTime.now()
                      ..amount = int.parse(titleController.text);
                    programProvider.addToExpenseList(dataLocal);
                    titleController.clear();
                    subtitleController.clear();
                    selection = "Baba";
                    Navigator.pop(context);
                  }
                }
                },
                child: const Text("Ekle"),
              ),
            ],
          );
  }
}
