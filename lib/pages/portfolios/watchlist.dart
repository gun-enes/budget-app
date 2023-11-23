import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/pages/portfolios/watchlist_datacard.dart';
import 'package:sql_project2/services/invest_provider.dart';
import 'package:sql_project2/services/models/watchlist.dart';
import '../../services/program_provider.dart';


class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  int currentIndex = 0;
  final formGlobalKey = GlobalKey < FormState > ();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    List<WatchListDataModel> watchlist = investProvider.watchList;
    titleController.text = investProvider.hissekodlari[0];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Yeni Takip Ekle"),
                  content: DropdownSearch<String>(
                    popupProps: const PopupProps.dialog(
                      searchDelay: Duration(milliseconds: 0),
                      showSearchBox: true,
                      showSelectedItems: true,
                    ),
                    items: investProvider.hissekodlari,
                    onChanged: (value) {
                      titleController.text = value!;
                    },
                    selectedItem: investProvider.hissekodlari[0],
                  ),
                  /*Form(
                    key: formGlobalKey,
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Takip Edeceğiniz Hisse Kodu",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Lütfen bir hisse kodu giriniz";
                        }
                        else if(!programProvider.returnName(value)){
                          return 'Geçerli bir hisse kodu giriniz!';
                        }
                        return null;
                      },
                    ),
                  ),*/
                  actions: [
                    TextButton(
                      onPressed: () {
                          WatchListDataModel dataLocal = WatchListDataModel()..title = titleController.text;
                          investProvider.addToWatchList(dataLocal);
                          Navigator.pop(context);
                      },
                      child: const Text("Ekle"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("İptal"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Takip Listesi"),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8,),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: RefreshIndicator(
                  onRefresh: investProvider.getData,
                  child: ListView.builder(
                      itemCount: watchlist.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        int reverse = watchlist.length - 1 - index;
                        return Column(
                          children: [
                            WatchListDataCard(data: watchlist[reverse], index: reverse),
                          ],
                        );
                      }
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
