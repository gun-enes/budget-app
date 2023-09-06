import 'package:isar/isar.dart';
part 'expense_data_model.g.dart';

@Collection()
class ExpenseDataModel {
  Id id = Isar.autoIncrement;
  late String type;
  late String title;
  late DateTime date;
  late int amount;
}