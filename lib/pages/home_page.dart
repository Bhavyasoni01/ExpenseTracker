import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/transaction_model.dart';
import 'package:notes_app/pages/transaction_history.dart';
import 'package:notes_app/pages/transcations.dart';
import 'package:notes_app/services/hive_services.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionModel> recentTransactions = [];
  double totalBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpenses = 0.0;
  bool isRefreshing = false;

  @override
  void initState(){
    super.initState();
    _loadData();
  }

  void _loadData (){
    setState(() {
      recentTransactions = HiveService.getRecentTransactions();
      totalBalance = HiveService.getBalance();
      totalIncome = HiveService.getIncome();
      totalExpenses = HiveService.getExpense();
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      isRefreshing = true;
    });

    await Future.delayed(Duration(milliseconds: 500));

    try {
      setState(() {
        recentTransactions = HiveService.getRecentTransactions();
        totalBalance = HiveService.getBalance();
        totalIncome = HiveService.getIncome();
        totalExpenses = HiveService.getExpense();
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Refreshed Successfully',),
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error Refreshing'),
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        isRefreshing = false;
      });
    }
  }
    


  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          color: Colors.deepPurple,
          backgroundColor: Colors.white,
          strokeWidth: 3,
          displacement: 50,
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Text('Home',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(child: Icon(CupertinoIcons.square_grid_2x2_fill, size: 25)),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.bell_fill,
                        size: 22,),
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
            
                const SizedBox(height: 30,),
            
                Bounce(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [ Color(0xFF4FC3F7), Color(0xFF9C27B0), Color(0xFFE91E63),],
                        
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        transform: GradientRotation(321)),
                        borderRadius: BorderRadius.circular(25), 
                        boxShadow: [BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0,4),
                        )]
                        
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Balance",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'InterFont',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹${NumberFormat('#,##,###.##').format(totalBalance)}',
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Income",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18
                                    ),
                                  ),
                                  Text(
                                    '₹${NumberFormat('#,##,###.##').format(totalIncome)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 70,),
                             Expanded(child: 
                             Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(Icons.arrow_upward,
                                  color: Colors.white,
                                  size: 16,),
                                ),
                                SizedBox(width: 8,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Expenses',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18
                                    ),),
                            
                                    Text('₹${NumberFormat('#,##,###.##').format(totalExpenses)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                )
                              ],
                             ))
                            ],
                          ),   
                        ],                   
                      ),
                      ),               
                    ),
                  ),
                ),
                 const SizedBox(height: 25,),
            
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Recent Transactions',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'InterFont'
                          ),),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> TransactionHistoryPage()));
                            },
                            child: Text('See All',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600]
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 30,),
          
                  if(recentTransactions.isEmpty)
                  Padding(padding: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(Icons.receipt_long,
                      size: 64,
                      color: Colors.grey[400]
                      ),
                      SizedBox(height: 15,),
                      Text('No Transactions Yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 8,),
                      Text('Add your first income or expense to get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[500]
                      ),)
                    ],
                  ),)
          
                  else
                    ...recentTransactions.map((transaction) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: TranscationsBuild(
                          icon: transaction.logoPath,
                          iconColor: Colors.black,
                          title: transaction.description,
                          date: DateFormat('dd MMM yyyy').format(transaction.date),
                          amount: '₹${NumberFormat('#,##,###.##').format(transaction.amount)}',
                          isExpense: transaction.isExpense,
                        ),
                      );
                    }).toList(),
             ],             
                      ),
                      
                    ),
                  ]),
        )));
  }
}