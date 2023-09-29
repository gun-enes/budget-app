import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/invest_provider.dart';

import '../../services/models/portfolio_datamodel.dart';
class AddPortfolio extends StatefulWidget {
  const AddPortfolio({Key? key, }) : super(key: key);
  @override
  State<AddPortfolio> createState() => _AddPortfolioState();
}

class _AddPortfolioState extends State<AddPortfolio> {

  final formGlobalKey = GlobalKey < FormState > ();
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    return AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formGlobalKey,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Bu alan boş bırakılamaz!';
              }
              return null;
            },
            controller: titleController,
            decoration: const InputDecoration(
              labelText: "Portfolyo adı giriniz",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (formGlobalKey.currentState!.validate()) {
              final dataLocal = PortfolioDataModel()..title = titleController.text;
              investProvider.addToPortfolioList(dataLocal);
              titleController.clear();
              Navigator.pop(context);
            }
          },
          child: const Center(child: Text("Ekle")),
        ),
      ],
    );
  }

}
