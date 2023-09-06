import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sql_project2/pages/month/expenses_bymonth.dart';
import '../../services/models/monthly_data_model.dart';

class DataCard4 extends StatefulWidget {
  const DataCard4({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final MonthlyDataModel data;
  final int index;
  @override
  State<DataCard4> createState() => _DataCard4State();
}

class _DataCard4State extends State<DataCard4> {
  late DateFormat trvakti;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    trvakti = DateFormat.yMMMMd('tr');
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExpensesByMonth(date: widget.data.title)),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          //color: Colors.yellow,
          semanticContainer: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${DateFormat.yMMMM("tr_TR").format(widget.data.title)} ayı özeti"),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Text("  Gelirler ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      SizedBox(height: 5,),
                      Text("   Giderler ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      SizedBox(height: 5,),
                      Text("Net     ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(width: 50,),
                  Column(
                    children: [
                      Text("₺${widget.data.income}  ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green[500])),
                      const SizedBox(height: 5,),
                      Text("₺${widget.data.expense}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.red[500])),
                      const SizedBox(height: 5,),
                      Text("₺${widget.data.income - widget.data.expense}  ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.blue[400]))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14,),
            ],
          )
      ),
    );
  }
}
