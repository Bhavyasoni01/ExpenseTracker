

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/transaction_model.dart';
import 'package:notes_app/pages/transcations.dart';
import 'package:notes_app/services/hive_services.dart';
import 'package:notes_app/utils/pie_chart.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  int selectedToggleIndex = 0;

  List <TransactionModel> getExpenseTransactions = [];
  List <TransactionModel> getIncomeTransactions = [];
  double totalIncome = 0.0;
  double totalExpenses = 0.0;

  @override
  void initState(){
    super.initState();
    _loadData();
  }

  void _loadData(){
    setState(() {
      totalIncome = HiveService.getIncome();
      totalExpenses = HiveService.getExpense();
      getIncomeTransactions = HiveService.getIncomeTransactions();
      getExpenseTransactions = HiveService.getExpenseTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text('Overview',
              style: TextStyle(
                fontWeight: FontWeight.w500
              ),),
              leading: Padding(padding: EdgeInsets.only(left: 8),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: IconButton(
                    onPressed: (){

                    },
                   icon: Icon(CupertinoIcons.square_grid_2x2_fill)),
                ),)
              ),

              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Bounceable(
                         onTap: (){},

                          child: Container(
                            
                            height: 110,
                            width: 170,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              boxShadow:[ BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.5), 
                                spreadRadius: 2, 
                                blurRadius: 5, 
                                offset: Offset(0, 3),
                              )],
                              color: Color.fromRGBO(203, 170, 243, 1).withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(21),
                            ),
                          
                            child: Column(
                              children: [
                                Text('Total Income',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'InterFont'
                                ),),
                          
                                SizedBox(height: 15,),
                          
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.5),
                                      child: Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                        child: Icon(Icons.arrow_downward_rounded,
                                        color: Colors.white,
                                        size: 18,),
                                      ),
                          
                          
                                      
                                    ),
                                    SizedBox(width: 5,),
                                    Text('₹${NumberFormat('#,##,###.##').format(totalIncome)}',
                                    style: TextStyle(
                                      fontSize: 16.7,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                    ),)
                                  ],
                                ),
                          
                                
                              ],
                            ),
                          ),
                        ),


                          SizedBox(width: 15,),

                        Row(
                      children: [
                        Bounceable(
                           onTap: (){},

                          child: Container(
                            height: 110,
                            width: 170,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              boxShadow:[ BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.5), 
                                spreadRadius: 2, 
                                blurRadius: 5, 
                                offset: Offset(0, 3),
                              )],
                              color: Color.fromRGBO(235, 167, 91, 1).withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(21),
                            ),
                          
                            child: Column(
                              children: [
                                Text('Total Expense',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'InterFont'
                                ),),
                          
                                SizedBox(height: 15,),
                          
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.5),
                                      child: Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          color: Colors.orange[800],
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                        child: Icon(Icons.arrow_upward_rounded,
                                        color: Colors.white,
                                        size: 18,),
                                      ),
                          
                          
                                      
                                    ),
                                    SizedBox(width: 5,),
                                    Text('₹${NumberFormat('#,##,###.##').format(totalExpenses)}',
                                    style: TextStyle(
                                      fontSize: 16.7,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                    ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        ),
                          ],
                        ),
                      ],
                    ),
                  ),

                    SizedBox(height: 30,),

                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Text('Breakdown',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500
                        ),),
                      )
                    ],),

                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: PieChartTotal(),
                    ),

                    SizedBox(height: 30,),

                    Center(
                      child: ToggleSwitch(
                        minWidth: 200,
                        minHeight: 50,
                        initialLabelIndex: selectedToggleIndex,
                        cornerRadius: 10,
                        activeFgColor: Colors.black,
                        inactiveBgColor: Colors.grey[400],
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: ['Income', 'Expense',],
                        
                        fontSize: 16,
                        animate: false, 
                        activeBgColor: [Colors.orange,],
                        onToggle: (index){
                            setState(() {
                              selectedToggleIndex = index!;
                            });
                        },
                    ),
                  ),
                  SizedBox(height: 30,),

                  _buildTransactions(),

                  SizedBox(height: 30,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactions(){
    if(selectedToggleIndex == 0){
      if(getIncomeTransactions.isEmpty){
        return Padding(padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.trending_up),
            SizedBox(height: 15,),
            Center(
              child: Text('No Income Transactions',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),),
            ),
            SizedBox(height: 8,),
            Center(
              child: Text("Add you first income to get Started",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[500]),),
            ),
          ],
        ),
        );
      }else{
        return Column(
          children: [
            Padding(padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                
              ],
            ),),
            ...getIncomeTransactions.map((transaction){
              return Padding(padding: EdgeInsets.only(bottom: 15),
              child: TranscationsBuild(
              icon: transaction.logoPath, 
              iconColor: Colors.black, 
              title: transaction.description, 
              date: DateFormat('dd MMM yyyy').format(transaction.date), 
              amount: '₹${NumberFormat('#,##,###.##').format(transaction.amount)}', 
              isExpense: transaction.isExpense),
              
              
              );
            }).toList(),
          ],
        );
      }
    }else{
      if(getExpenseTransactions.isEmpty){
        return Padding(padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.trending_down),
            SizedBox(height: 15,),
            Center(
              child: Text('No Expense Transactions',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),),
            ),
            SizedBox(height: 8,),
            Center(
              child: Text("Add you first expense to get Started",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[500]),),
            ),
          ],
        ),
        );
      }else{
        return Column(
          children: [
            Padding(padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                
              ],
            ),),
            ...getExpenseTransactions.map((transaction){
              return Padding(padding: EdgeInsets.only(bottom: 15),
              child: TranscationsBuild(
              icon: transaction.logoPath, 
              iconColor: Colors.black, 
              title: transaction.description, 
              date: DateFormat('dd MMM yyyy').format(transaction.date), 
              amount: '₹${NumberFormat('#,##,###.##').format(transaction.amount)}', 
              isExpense: transaction.isExpense),
              
              
              );
            }).toList(),
          ],
        );
    }}
    
  }



}
