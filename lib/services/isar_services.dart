import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sql_project2/services/models/cash.dart';
import 'package:sql_project2/services/models/monthly_data_model.dart';
import 'package:sql_project2/services/models/portfolio_datamodel.dart';
import 'package:sql_project2/services/models/stock_datamodel.dart';
import 'package:sql_project2/services/models/watchlist.dart';

import 'models/daily_data_model.dart';
import 'models/expense_data_model.dart';
import 'models/income_data_model.dart';

class IsarService {
  static late Future<Isar> db;
  IsarService() {
    db = openDB();
  }
  Future<void> addIncome(IncomeDataModel newData) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.incomeDataModels.putSync(newData));
  }

  Future<void> deleteIncome(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.incomeDataModels.delete(id);
    });
  }

  static Future<List<IncomeDataModel>> getAllIncome(Isar isar) async {
    return await isar.incomeDataModels.where().findAll();
  }
  Future<void> addExpense(ExpenseDataModel newData) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.expenseDataModels.putSync(newData));
  }

  Future<void> deleteExpense(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.expenseDataModels.delete(id);
    });
  }/*
  Future<void> updateExpense(ExpenseDataModel oldData, ExpenseDataModel newData)async {
    final isar = await db;
    ExpenseDataModel k = isar.expenseDataModels.where().filter().idEqualTo(oldData.id) as ExpenseDataModel;
  }*/
  static Future<List<ExpenseDataModel>> getAllExpense(Isar isar) async {
    return await isar.expenseDataModels.where().findAll();
  }

  Future<void> addDaily(DailyDataModel newData) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.dailyDataModels.putSync(newData));
  }

  Future<void> deleteDaily(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.dailyDataModels.delete(id);
    });
  }
  static Future<List<StockDataModel>> getAllStocks(Isar isar) async {
    return await isar.stockDataModels.where().findAll();
  }
  Future<void> addStock(StockDataModel newData) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.stockDataModels.putSync(newData));
  }

  Future<void> deleteStock(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.stockDataModels.delete(id);
    });
  }

  Future<void> updateStock(StockDataModel oldData,StockDataModel newData)async {
    final isar = await db;
    final items = isar.stockDataModels;
    await isar.writeTxn(() async {
      final item = await items.where().idEqualTo(oldData.id).findFirst();
      if (item != null) {
        print(newData.portfolio);
        print(oldData.portfolio);
        item.portfolio = newData.portfolio;
        item.title = newData.title;
        item.amount = newData.amount;
        item.price = newData.price;
        item.date = newData.date;
        await items.put(item);
      }
    }
    );
  }

  static Future<List<PortfolioDataModel>> getAllPortfolios(Isar isar) async {
    return await isar.portfolioDataModels.where().findAll();
  }

  Future<void> addPortfolio(PortfolioDataModel newData) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.portfolioDataModels.putSync(newData));
  }

  Future<void> deletePortfolio(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.portfolioDataModels.delete(id);
    });
  }
  Future<void> updatePortfolio(PortfolioDataModel oldData,PortfolioDataModel newData)async {
    final isar = await db;
    final items = isar.portfolioDataModels;
    await isar.writeTxn(() async {
      final item = await items.where().idEqualTo(oldData.id).findFirst();
      if (item != null) {
        item.title = newData.title;
        await items.put(item);
      }
    }
    );
  }
  Future<void> updateMoney(IncomeDataModel oldData)async {
    final isar = await db;
    final items = isar.expenseDataModels;
    await isar.writeTxn(() async {
      final item = await items.where().idEqualTo(oldData.id).findFirst();
      if (item != null) {
        item.type = "Income";
        await items.put(item);
      }
    }
    );
  }

  static Future<List<DailyDataModel>> getAllDaily(Isar isar) async {
    return await isar.dailyDataModels.where().findAll();
  }
  Future<void> addMonthly(MonthlyDataModel newData) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.monthlyDataModels.putSync(newData));
  }

  Future<void> deleteMonthly(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.monthlyDataModels.delete(id);
    });
  }

  static Future<List<MonthlyDataModel>> getAllMonthly(Isar isar) async {
    return await isar.monthlyDataModels.where().findAll();
  }
  Future<void> deleteWatchList(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.watchListDataModels.delete(id);
    });
  }
  Future<void> updateWatchList(WatchListDataModel oldData,WatchListDataModel newData)async {
    final isar = await db;
    final items = isar.watchListDataModels;
    await isar.writeTxn(() async {
      final item = await items.where().idEqualTo(oldData.id).findFirst();
      if (item != null) {
        item.title = newData.title;
        await items.put(item);
      }
    }
    );
  }

  Future<void> addWatchlist(WatchListDataModel newData) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.watchListDataModels.putSync(newData));
  }
  static Future<List<WatchListDataModel>> getAllWatchList(Isar isar) async {
    return await isar.watchListDataModels.where().findAll();
  }

  Future<void> addCash(CashDataModel newData) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.cashDataModels.putSync(newData));
  }
  Future<void> updateCash(CashDataModel oldData,CashDataModel newData)async {
    final isar = await db;
    final items = isar.cashDataModels;
    await isar.writeTxn(() async {
      final item = await items.where().idEqualTo(oldData.id).findFirst();
      if (item != null) {
        item.portfolio = newData.portfolio;
        item.cash = newData.cash;
        await items.put(item);
      }
    }
    );
  }
  static Future<List<CashDataModel>> getAllCash(Isar isar) async {
    return await isar.cashDataModels.where().findAll();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  static Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [IncomeDataModelSchema,DailyDataModelSchema,ExpenseDataModelSchema,MonthlyDataModelSchema,StockDataModelSchema,PortfolioDataModelSchema,WatchListDataModelSchema,CashDataModelSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}