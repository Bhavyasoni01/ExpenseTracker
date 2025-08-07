import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/pages/add_expense.dart';
import 'package:notes_app/pages/add_income.dart';
import 'package:notes_app/services/hive_services.dart';
import 'package:notes_app/models/transaction_model.dart';
import 'package:notes_app/pages/transaction_history.dart';
import 'package:notes_app/pages/transcations.dart';


class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  List<TransactionModel> recentTransactions = [];

  @override
  void initState(){
    super.initState();
    _loadData();
  }

  void _loadData (){
    setState(() {
      recentTransactions = HiveService.getRecentTransactions();
    });
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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text('Add',
              style: TextStyle(
                fontWeight: FontWeight.w500
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
                  child: Icon(CupertinoIcons.back),
                ),
              ),
              
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
              
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(  
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddIncome()));
                            },
                            child: Container(
                              height: 120,
                              width: 170,          
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 162, 143, 240),
                                borderRadius: BorderRadius.circular(21),
                                boxShadow:[ BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5), 
                              spreadRadius: 2, 
                              blurRadius: 5, 
                              offset: Offset(0, 3),
                            )],
                              ),
                              
                              child: Column(
                                children: [
                                  Image.asset('assets/images/ccadd.png',
                                  cacheHeight: 50,),
                                  Text('Add Income',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                       Row(
                        children: [
                          GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddExpense()));
                          },
                          child: Container(
                            height: 120,
                            width: 170,          
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 230, 190, 131),
                              borderRadius: BorderRadius.circular(21),
                              boxShadow:[ BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5), 
                              spreadRadius: 2, 
                              blurRadius: 5, 
                              offset: Offset(0, 3),
                            )],
                            ),
                            
                            child: Column(
                              children: [
                                Image.asset('assets/images/ccminus.png',
                                cacheHeight: 50,),
                                Text('Add Expense',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                 
                                ),),
                              ],
                            ),
                          ),
                        ),
                        ],
                       )
                      ],
                    ),
                  ),
              
              
                    SizedBox(height: 30,),
              
              
                    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Last Added',
                        style: TextStyle(
                          fontSize: 20,
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
              
              
                SizedBox(height: 20,),
              
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
            )
            
          ],
        

      ),
      ),
    );
  }
}