import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)

class TransactionModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late String logoPath;

  @HiveField(5)
  late bool isExpense;

  @HiveField(6)
  late String category;



  TransactionModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.isExpense,
    required this.category,
    required this.logoPath
  });


  // Converting it to map coz its easy to debug in map
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'logopath': logoPath,
      'isExpense': isExpense,
      'category': category,
    };
  }

}