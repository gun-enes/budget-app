import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import '../../services/models/stock_datamodel.dart';
import '../../services/program_provider.dart';

class StockPopUp extends StatefulWidget {

  const StockPopUp({Key? key}) : super(key: key);

  @override
  State<StockPopUp> createState() => _StockPopUpState();
}

class _StockPopUpState extends State<StockPopUp> {
  final formGlobalKey = GlobalKey < FormState > ();
  final formGlobalKey2 = GlobalKey < FormState > ();
  final formGlobalKey3 = GlobalKey < FormState > ();
  final formGlobalKey4 = GlobalKey < FormState > ();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController portfolioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    bool controller = false;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(14),
      content: SizedBox(
        height: 270,
        child: Column(
          children: [
            Form(
              key: formGlobalKey,
              child: TextFormField(
                onTap: (){
                  programProvider.createPortfolio();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bu alan boş bırakılamaz!';
                  }
                  else if(!programProvider.returnName(value)){
                    return 'Geçerli bir hisse kodu giriniz!';
                  }
                  return null;
                },
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: "Hisse Adı"
                ),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: formGlobalKey4,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bu alan boş bırakılamaz!';
                  }
                  else if(!programProvider.returnPortfolioName(value)){
                    return 'Geçerli bir portfolyo giriniz!';
                  }
                  else if(programProvider.returnStockInPortfolio(portfolioController.text, titleController.text)  < int.parse(amountController.text) && controller){
                    return 'Sahip olduğunuzdan fazlasını satamazsınız!';
                  }
                  return null;
                },
                controller: portfolioController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: "Portfolio Adı"
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 122,
                  child: Form(
                    key: formGlobalKey2,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bu alan boş bırakılamaz!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          labelText: "Miktar"
                      ),
                    ),
                  ),
                ),
                Form(
                  key: formGlobalKey3,
                  child: SizedBox(
                    width: 122,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bu alan boş bırakılamaz!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          labelText: "Fiyat"
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                if (formGlobalKey.currentState!.validate()) {
                  if(formGlobalKey4.currentState!.validate()) {
                    if (formGlobalKey2.currentState!.validate()) {
                      if (formGlobalKey3.currentState!.validate()) {
                        final dataLocal = StockDataModel()
                          ..date = DateTime.now()
                          ..title = titleController.text
                          ..price = double.parse(priceController.text)
                          ..portfolio = portfolioController.text
                          ..amount = int.parse(amountController.text);
                        programProvider.addToStockList(dataLocal);
                        titleController.clear();
                        priceController.clear();
                        amountController.clear();
                        Navigator.pop(context);
                      }
                    }
                  }
                }
              },
              child: const Center(child: Text("Al")),
            ),
            TextButton(
              onPressed: () {
                if (formGlobalKey.currentState!.validate()) {
                  if (formGlobalKey2.currentState!.validate()) {
                    if (formGlobalKey3.currentState!.validate()) {
                      controller = true;
                      if (formGlobalKey4.currentState!.validate()){
                        final dataLocal = StockDataModel()
                          ..date = DateTime.now()
                          ..title = titleController.text
                          ..portfolio = portfolioController.text
                          ..price = double.parse(priceController.text)
                          ..amount = -int.parse(amountController.text);
                        final dataLocal2 = ExpenseDataModel()
                          ..type = "Income"
                          ..date = DateTime.now()
                          ..amount = (int.parse(amountController.text)*(double.parse(priceController.text) - programProvider.returnCost(titleController.text))).toInt()
                          ..title = "Borsa";
                        programProvider.addToExpenseList(dataLocal2);
                        programProvider.addToStockList(dataLocal);
                        titleController.clear();
                        priceController.clear();
                        amountController.clear();
                        programProvider.createPortfolio();
                        Navigator.pop(context);
                      }
                    }
                  }
                }
              },
              child: const Center(child: Text("Sat")),
            ),
          ],
        ),
      ],
    );
  }
}
