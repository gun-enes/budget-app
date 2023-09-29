import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/invest_provider.dart';

import '../../services/models/portfolio_datamodel.dart';
class UpdatePortfolio extends StatefulWidget {
  final PortfolioDataModel data;
  const UpdatePortfolio(this.data, {Key? key, }) : super(key: key);
  @override
  State<UpdatePortfolio> createState() => _UpdatePortfolioState();
}

class _UpdatePortfolioState extends State<UpdatePortfolio> {

  final formGlobalKey = GlobalKey < FormState > ();
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    titleController.text = widget.data.title;
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
              investProvider.updatePortfolioList(widget.data, dataLocal);
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