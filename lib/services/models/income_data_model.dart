import 'package:isar/isar.dart';
part 'income_data_model.g.dart';

@Collection()
class IncomeDataModel {
  Id id = Isar.autoIncrement;
  late String title;
  late DateTime date;
  late int amount;
}
