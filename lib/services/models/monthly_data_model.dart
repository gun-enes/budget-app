import 'package:isar/isar.dart';
part 'monthly_data_model.g.dart';

@Collection()
class MonthlyDataModel {
  Id id = Isar.autoIncrement;
  late DateTime title;
  late int income;
  late int expense;
}