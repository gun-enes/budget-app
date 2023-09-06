/*import 'dart:core';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/income_data_model.dart';

class categories extends StatefulWidget {
  const categories({Key? key}) : super(key: key);

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  late DB db;
  int touchedIndex = 5;
  int limit = 200;
  List<DataModel> datas = [];
  List<int> spent = [];
  List<int> spent2 = [];
  bool fetching2 = true;
  List<String> cats2 = [];
  List<String> cats = [
    "Market",
    "Yemek",
    "Alkol",
    "Nargile",
    "Cafe",
    "Para Çekme",
    "Borç",
    "Ulaşım",
    "Su",
    "Sigara",
    "Giyim",
    "Taksitler",
    "Berber",
    "Alışveriş"
  ];
  bool control = false;

  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();
  }

  void getData2() async {
    datas = await db.getData();
    setState(() {
      fetching2 = false;
    });
  }
  void cat(){
      for (final data in datas) {
        for (int j = 0; j < cats.length; j++) {
          if (spent.length < cats.length) {
            spent.add(0);
          }
          if (data.subtitle.toUpperCase() == cats[j].toUpperCase()) {
            spent[j] += (int.parse(data.title));
            print(spent[j]);
          }
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    cat();
    return Scaffold(
      body: Column(
        children: [
          fetching2 ?
          const Center(
            child: CircularProgressIndicator(),
          ):
              Stack(
                alignment: Alignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cats[touchedIndex == -1 ? 5:touchedIndex], style: TextStyle(fontSize: 18),),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 1,
                        centerSpaceRadius: 120,
                        sections: showingSections(),
                      ),
                    ),
              ),
            ],
          ),
          fetching2 ?
          const Center(
            child: CircularProgressIndicator(),
          ):
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  itemCount: cats.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    int reverse = datas.length - 1 - index;
                    return ListTile(
                      title: Text(cats[index]),
                      trailing: Text(spent[index].toString()),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 25.0 : 15.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.purple,
            value: spent[0].toDouble(),
            title: "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: spent[3].toDouble(),
            title: "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: spent[2].toDouble(),
            title: "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: spent[1].toDouble(),
            title: "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

}*/

