import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:notes_app/models/transaction_model.dart';


class HiveService {
  static const String _transactionBoxName = 'transactions';
  static Box<TransactionModel>? _transactionBox;

  static Future<void> init() async{
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionModelAdapter());

    _transactionBox = await Hive.openBox<TransactionModel>(_transactionBoxName);

  }
    static Box<TransactionModel>? get transactionBox => _transactionBox;

     static Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionBox?.put(transaction.id, transaction);
  }

  static List<TransactionModel> getAllTransactions(){
    return _transactionBox?.values.toList() ?? [];
  }

  static List<TransactionModel> getTransactionsByType(bool isExpense){
    return _transactionBox?.values
    .where((transaction) => transaction.isExpense == isExpense)
    .toList() ?? [];
  }

  static Future<void> deleteTransaction(String id) async {
    await _transactionBox?.delete(id);
  }

  static Future<void> updateTransaction(TransactionModel transaction) async {
    await _transactionBox?.put(transaction.id, transaction);
  }

  static double getBalance(){
    final transactions = getAllTransactions();
    double balance = 0.0;

    for (TransactionModel transaction in transactions){
      if(transaction.isExpense){
        balance -= transaction.amount;
      } else {
        balance += transaction.amount;
      }
    }
     
     return balance;


  }

  static double getIncome(){
    final incomeTransactions = getTransactionsByType(false);
    return incomeTransactions.fold(0.0, (sum, transaction)=> sum+transaction.amount);
  }

  static double getExpense(){
    final expenseTransactions  = getTransactionsByType(true);
    return expenseTransactions.fold(0.0, (sum, transaction)=> sum+transaction.amount);
  }

  static List<TransactionModel> getRecentTransactions(){
    final transactions = getAllTransactions();
    transactions.sort((a,b)=> b.date.compareTo(a.date));
    return transactions.take(5).toList();
  }

  static Future<void> closeBoxes() async{
    await _transactionBox?.close();
  }

  static List<TransactionModel> getExpenseTransactions(){
    final expenseTransactions = getTransactionsByType(true);
    expenseTransactions.sort((a, b) => b.date.compareTo(a.date),);
    return expenseTransactions;
  }

  static List<TransactionModel> getIncomeTransactions(){
    final incomeTransactions = getTransactionsByType(false);
    incomeTransactions.sort((a, b) => b.date.compareTo(a.date),);
    return incomeTransactions;
  }

  
  


}