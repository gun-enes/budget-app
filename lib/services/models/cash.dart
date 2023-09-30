import 'package:isar/isar.dart';
part 'cash.g.dart';

@Collection()
class CashDataModel {
  Id id = Isar.autoIncrement;
  late double cash;
  late String portfolio;
}