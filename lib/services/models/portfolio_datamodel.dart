import 'package:isar/isar.dart';
part 'portfolio_datamodel.g.dart';

@Collection()
class PortfolioDataModel {
  Id id = Isar.autoIncrement;
  late String title;
}