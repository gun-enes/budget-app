import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sql_project2/services/invest_provider.dart';
import 'package:sql_project2/services/program_provider.dart';
import 'package:sql_project2/pages/alltime/day_datacard.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'categories.dart';

class AllTime extends StatefulWidget {
  const AllTime({Key? key}) : super(key: key);
  @override
  State<AllTime> createState() => _AllTimeState();
}

class _AllTimeState extends State<AllTime> {
  int limit = 200;
  int initialMoney = 0;
  bool control = false;
  final formGlobalKey = GlobalKey < FormState > ();
  late DateFormat trvakti;
  TextEditingController titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    trvakti = DateFormat.MMMM('tr');
    _loadCounter();
    _loadCounter2();
    Future.delayed(
      const Duration(seconds: 0),(){
      Provider.of<ProgramProvider>(context, listen: false).setLimit(limit);
    }
    );
  }
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      limit = (prefs.getInt('limit') ?? 200);
    });
  }
  Future<void> _loadCounter2() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      initialMoney = (prefs.getInt('initialMoney') ?? 0);
    });
  }

  Future<void> _setInitialMoney(int val) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      initialMoney = val;
      prefs.setInt('initialMoney', initialMoney);
    });
  }
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      limit = (prefs.getInt('limit') ?? 200) + 25;
      prefs.setInt('limit', limit);
    });
  }
  Future<void> _decrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      limit = (prefs.getInt('limit') ?? 200) - 25;
      prefs.setInt('limit', limit);
    });
  }
  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    int x = programProvider.limit_outcome() - programProvider.sum_days();
    InvestProvider investProvider = Provider.of<InvestProvider>(context);
    return Scaffold(
      /*appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Column(
          children: [
            Text("₺${(programProvider.sum_income()-programProvider.sum_outcome() + initialMoney - investProvider.returnValue() + investProvider.returnProfit()).toStringAsFixed(2)}",style: const TextStyle(fontSize: 28),),
            Text("Bakiye", style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400,fontSize: 14),),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories())),
            icon: const Icon(Icons.bar_chart,),
          ),
        ],
      ),*/
      //drawer: const NavDraw(),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          programProvider.deleteall();
        },
        label: const Text("Günü Bitir"),
      ),
      body: SafeArea(
        child: Column(
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width:  10,),
                    Text("₺${(programProvider.sum_income()-programProvider.sum_outcome() + initialMoney - investProvider.returnValue() + investProvider.returnProfit()).toStringAsFixed(2)}",style: const TextStyle(fontSize: 28),),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories())),
                      icon: const Icon(Icons.bar_chart,),
                    ),
                    IconButton(
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
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
                                  keyboardType: TextInputType.number,
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      labelText: "Başlangıç paranız $initialMoney",
                                    border: const OutlineInputBorder(
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
                                        int val = int.parse(
                                            titleController.text.toString());
                                        _setInitialMoney(val);
                                        titleController.clear();
                                        Navigator.pop(context);
                                    }
                                  },
                                child: const Center(child: Text("Onayla")),
                              ),
                            ],
                          )
                      ),
                      icon: const Icon(Icons.settings),
                    )
                  ],
                )
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width:  10,),
                Text("Bakiye", style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400),),
              ],
            ),

            const SizedBox(height: 15,),
            GestureDetector(
              onTap: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Categories()),
                );},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 2,
                  semanticContainer: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Text("${trvakti.format(DateTime.now())} ayı özeti"),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Text("  Gelirler ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                              SizedBox(height: 5,),
                              Text("   Giderler ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                            ],
                          ),
                          const SizedBox(width: 50,),
                          Column(
                            children: [
                              Text("₺${programProvider.incomeCurrentMonth()}  ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green[500])),
                              const SizedBox(height: 5,),
                              Text("₺${programProvider.expenseCurrentMonth()}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.red[500])),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 140,),
                                x < 0 ?
                                Text("₺${-x} eksidesiniz.",style: const TextStyle(fontSize: 15),)
                                    :
                                Text("₺$x artıdasınız.",style: const TextStyle(fontSize: 15),),
                              ],
                            ),
                            IconButton(
                                onPressed: (){setState(() {
                                  if(control) {
                                    control = false;
                                  } else {
                                    control = true;
                                  }
                                });},
                                icon: Icon(control ? Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined)),
                          ],
                        ),
                      control ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          const Row(
                            children: [
                              SizedBox(width: 10,),
                              Text("Harcama limiti", style: TextStyle(fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (limit > 0) {
                                      _decrementCounter();
                                      programProvider.setLimit(limit-25);
                                    }
                                  },
                                  icon: const Icon(Icons.remove)
                              ),
                              Text("$limit"),
                              IconButton(
                                  onPressed: (){
                                    _incrementCounter();
                                    programProvider.setLimit(limit+25);
                                  },
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                        ],
                      ):const SizedBox(),
                      //SizedBox(height: 0,),
                    ],
                  )
                ),
              ),
            ),
            const SizedBox(height: 10,),
            programProvider.dailyList.isEmpty ? Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Align(alignment: Alignment.bottomCenter,child: Text("Günlük harcamalarınız burada gözükür", style: TextStyle(fontSize: 15, color: Colors.grey[500]),)),
            ):Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                        itemCount: programProvider.dailyList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index)  {
                          int reverse = programProvider.dailyList.length - 1 - index;
                          return DataCard2(
                            data: programProvider.dailyList[reverse],
                            limit: reverse == programProvider.dailyList.length - 1 ? 1:0,
                            index: reverse,
                          );
                        }
            ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
