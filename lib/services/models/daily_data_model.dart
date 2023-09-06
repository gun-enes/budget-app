import 'package:isar/isar.dart';
part 'daily_data_model.g.dart';

@Collection()
class DailyDataModel {
  Id id = Isar.autoIncrement;
  late int limit;
  late DateTime date;
  late int amount;
}