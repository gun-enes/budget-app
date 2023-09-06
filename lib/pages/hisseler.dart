import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_project2/services/program_provider.dart';

class Hisseler extends StatefulWidget {
  const Hisseler({Key? key}) : super(key: key);

  @override
  State<Hisseler> createState() => _HisselerState();
}

class _HisselerState extends State<Hisseler> {
  @override
  Widget build(BuildContext context) {
    ProgramProvider programProvider = Provider.of<ProgramProvider>(context);
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text("Borsa İstanbul Tüm Hisseler"),
        ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Sembol"),
                        ),
                      ),
                      VerticalDivider()
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 100,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text("Fiyat"),
                          )),
                      VerticalDivider(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Fark"),
                  ),
                )
              ],
            ),
            SizedBox(height: 1,child: Divider()),
            Expanded(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: RefreshIndicator(
                      onRefresh: programProvider.getData,
                      child: ListView.builder(
                          itemCount: programProvider.hissekodlari.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index)  {
                            return IntrinsicHeight(
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(programProvider.hissekodlari[index]),
                                              Text(programProvider.hisseisimleri[index], style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,)
                                            ],
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(),
                                    ],
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 45.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(programProvider.hissefiyati[index]),
                                              ],
                                            ),
                                          )),
                                      const VerticalDivider(),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 55.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(programProvider.hissedegisim[index]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                  //leading: Text(change[index]),
                                  //trailing: Text(hisseler[index])
                               ),
                            );
                          }
                      ),
                    )
                )
            )
          ],
        ),
      )
    );
  }
}
