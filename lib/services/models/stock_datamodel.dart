import 'package:isar/isar.dart';
part 'stock_datamodel.g.dart';

@Collection()
class StockDataModel {
  Id id = Isar.autoIncrement;
  late String title;
  late int amount;
  late double price;
  late String portfolio;
  late DateTime date;
}