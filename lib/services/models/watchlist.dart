import 'package:isar/isar.dart';
part 'watchlist.g.dart';

@Collection()
class  WatchListDataModel{
  Id id = Isar.autoIncrement;
  late String title;
}