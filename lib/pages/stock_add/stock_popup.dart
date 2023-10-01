import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/models/expense_data_model.dart';
import '../../services/invest_provider.dart';
import '../../services/models/cash.dart';
import '../../services/models/stock_datamodel.dart';
import '../../services/program_provider.dart';

class StockPopUp extends StatefulWidget {
  final String title;
  const StockPopUp({Key? key, required this.title}) : super(key: key);

  @override
  State<StockPopUp> createState() => _StockPopUpState();
}

class _StockPopUpState extends State<StockPopUp> {
  final formGlobalKey2 = GlobalKey < FormState > ();
  final formGlobalKey3 = GlobalKey < FormState > ();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController bistController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    bool controller = false;
    dolarController.text = investProvider.dollar;
    bistController.text = investProvider.bist;
    titleController.text = investProvider.hissekodlari[0];
    priceController.text = investProvider.returnPrice(titleController.text).toString();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DropdownSearch<String>(
              popupProps: const PopupProps.dialog(
                searchDelay: Duration(seconds: 0),
                showSearchBox: true,
                showSelectedItems: true
              ),
              items: investProvider.hissekodlari,
              onChanged: (value) {
                titleController.text = value!;
              },
              selectedItem: investProvider.hissekodlari[0],
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
                        else if((investProvider.returnStockInPortfolio(widget.title, titleController.text) < int.parse(amountController.text)) && controller){
                          controller = false;
                          return 'Sahip olduğunuzdan fazlasını satamazsınız!';
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 16),
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          labelText: "Miktar",
                          labelStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                investProvider.isCheckedForPrice ? SizedBox(
                  width: 122,
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      labelText: "Fiyat",
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ):
                SizedBox(
                  width: 122,
                  child: DropdownSearch<String>(
                    //mode: Mode.MENU,
                    popupProps: PopupProps.dialog(
                      //showSearchBox: true,
                      searchDelay: const Duration(seconds: 0),
                      searchFieldProps: const TextFieldProps(
                          style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          labelText: "Fiyat",
                          labelStyle: TextStyle(fontSize: 16),
                        )
                      ),
                      listViewProps: ListViewProps(
                        itemExtent: 50,
                        //scrollDirection: Axis.horizontal,
                        controller: ScrollController(initialScrollOffset: 25*investProvider.lengthOfPriceList(investProvider.returnPrice(titleController.text))),
                      ),
                      showSelectedItems: true,
                      //disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    items: List.generate(investProvider.lengthOfPriceList(investProvider.returnPrice(titleController.text)).toInt(), (index) => (investProvider.partOfPriceList(investProvider.returnPrice(titleController.text), index).toStringAsFixed(2))),
                    onChanged: (value) {
                      priceController.text = value!;
                    },
                    selectedItem: investProvider.returnPrice(titleController.text).toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            investProvider.isCheckedForDollar ? Row(
              children: [
                SizedBox(
                  width: 122,
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    controller: dolarController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      labelText: "Dolar Kuru",
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  width: 122,
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    controller: bistController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      labelText: "BIST",
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ):const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: investProvider.isCheckedForPrice,
                  onChanged: (bool? value) {
                    setState(() {
                      investProvider.isCheckedForPrice = value!;
                    });
                  },
                ),
                const Text('Fiyatı kendim girmek istiyorum'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: investProvider.isCheckedForDollar,
                  onChanged: (bool? value) {
                    setState(() {
                      investProvider.isCheckedForDollar = value!;
                    });
                  },
                ),
                const Text('Kuru kendim girmek istiyorum'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    if (formGlobalKey2.currentState!.validate()) {
                      final dataLocal = StockDataModel()
                        ..date = DateTime.now()
                        ..title = titleController.text
                        ..price = double.parse(priceController.text)
                        ..portfolio = widget.title
                        ..bist = double.parse(bistController.text.replaceAll(',', '.'))
                        ..dollar = double.parse(dolarController.text.replaceAll(',', '.'))
                        ..amount = int.parse(amountController.text);
                      investProvider.addToStockList(dataLocal);
                      titleController.clear();
                      priceController.clear();
                      amountController.clear();

                      CashDataModel data = CashDataModel()..portfolio = widget.title ..cash = investProvider.returnCash(widget.title) - int.parse(amountController.text)*double.parse(priceController.text);
                      investProvider.addToCashList(data);
                      programProvider.showSnackBar(context, "Alım işlemi başarılı");
                      Navigator.pop(context);
                    }
                  },
                  child: const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Al",style: TextStyle(fontSize: 15,color: Colors.white),),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    controller = true;
                    if (formGlobalKey2.currentState!.validate()) {
                      final dataLocal = StockDataModel()
                        ..date = DateTime.now()
                        ..title = titleController.text
                        ..portfolio = widget.title
                        ..price = double.parse(priceController.text)
                        ..bist = double.parse(bistController.text.replaceAll(',', '.'))
                        ..dollar = double.parse(dolarController.text.replaceAll(',', '.'))
                        ..amount = -int.parse(amountController.text);
                      final dataLocal2 = ExpenseDataModel()
                        ..type = "Income"
                        ..date = DateTime.now()
                        ..amount = (int.parse(amountController.text)*(double.parse(priceController.text) - investProvider.returnCost(titleController.text))).toInt()
                        ..title = "Borsa";
                      programProvider.addToExpenseList(dataLocal2);
                      investProvider.addToStockList(dataLocal);
                      titleController.clear();
                      priceController.clear();
                      amountController.clear();
                      CashDataModel data = CashDataModel()..portfolio = widget.title ..cash = investProvider.returnCash(widget.title) + int.parse(amountController.text)*double.parse(priceController.text);
                      investProvider.addToCashList(data);
                      investProvider.createPortfolio();
                      programProvider.showSnackBar(context, "Satış işlemi başarılı");
                      Navigator.pop(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Sat",style: TextStyle(fontSize: 15,color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
