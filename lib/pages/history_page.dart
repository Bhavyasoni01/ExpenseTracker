import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:notes_app/models/transaction_model.dart';
import 'package:notes_app/pages/transcations.dart';
import 'package:notes_app/services/hive_services.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<TransactionModel> allTransactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllTransactions();
  }

  void _loadAllTransactions() {
    try {
      setState(() {
        isLoading = true;
      });
      
      final transactions = HiveService.getAllTransactions();
      
      setState(() {
        allTransactions = transactions;
        allTransactions.sort((a, b) => b.date.compareTo(a.date)); 
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading transactions: $e')),
      );
    }
  }

  Future<void> _deleteTransaction(String transactionId) async {
    try {
      await HiveService.deleteTransaction(transactionId);
      _loadAllTransactions(); 
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction deleted successfully'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting transaction: $e')),
      );
    }
  }

  Future<bool> _deleteConfirmation(TransactionModel transaction) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Delete Transaction'),
          content: Text(
            'Are you sure you want to delete "${transaction.description}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Clear All Transactions'),
          content: const Text(
            'Are you sure you want to delete all transactions? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _clearAllTransactions();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _clearAllTransactions() async {
    try {
      
      for (var transaction in allTransactions) {
        await HiveService.deleteTransaction(transaction.id);
      }
      
      _loadAllTransactions();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All transactions cleared'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error clearing transactions: $e')),
      );
    }
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
              title: Text("Transactions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),),
              actions: [
                if (allTransactions.isNotEmpty)
            IconButton(
              onPressed: () {
                _showClearAllDialog();
              },
              icon: const Icon(CupertinoIcons.delete),
              tooltip: 'Clear All',
            ),
              ],

            ),

            if (isLoading)
                        SliverToBoxAdapter(
                          child: Container(
                            child: Center(
                                    child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      else if  (allTransactions.isEmpty)
                      SliverToBoxAdapter(
                        child: _buildEmptyState(),
                      )
                      else 
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final transaction = allTransactions[index];
                            return Dismissible(
                              key: Key(transaction.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                margin: EdgeInsets.only(bottom: 12),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await _deleteConfirmation(transaction);
                              },
                              onDismissed: (direction) {
                                _deleteTransaction(transaction.id);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 12, left: 10, right: 10),
                                child: TranscationsBuild(
                                  icon: transaction.logoPath,
                                  iconColor: Colors.black,
                                  title: transaction.description,
                                  date: DateFormat('dd MMM yyyy').format(transaction.date),
                                  amount: '₹${NumberFormat('#,##,###.##').format(transaction.amount)}',
                                  isExpense: transaction.isExpense,
                                ),
                              ),
                            );
                          },
                          childCount: allTransactions.length,
                        ),
                      ),
            ]),

      ),
    );
  }

  Widget _buildEmptyState(){
    return Center(
      child: Padding(padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_rounded,
          size: 80,
          color: Colors.grey[400],),
          SizedBox(height: 24,),
          Text('No Transactions Found',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          Text('Your Transactions will appear here',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
          ),)
        ],
      ),
      
      ),
    );
  }



}