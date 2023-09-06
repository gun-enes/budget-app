import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/models/monthly_data_model.dart';
import '../../services/program_provider.dart';
import 'month_datacard.dart';

class Months extends StatefulWidget {
  const Months({Key? key}) : super(key: key);

  @override
  State<Months> createState() => _MonthsState();
}

class _MonthsState extends State<Months> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  DateTime now = DateTime.now();
  List<MonthlyDataModel> datas = [];
  bool fetching = true;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Aylar"),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  itemCount: programProvider.monthlyList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    int reverse = programProvider.monthlyList.length - 1 - index;
                    return DataCard4(
                        data: programProvider.monthlyList[reverse],
                        index: reverse
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
