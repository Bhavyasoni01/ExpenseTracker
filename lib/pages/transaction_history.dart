import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/models/transaction_model.dart';
import 'package:notes_app/pages/transcations.dart';
import 'package:notes_app/services/hive_services.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : allTransactions.isEmpty
              ? _buildEmptyState()
              : _buildTransactionsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network('https://lottie.host/eea17818-76a5-473e-87a6-e25e1935534a/qWyjvXyelD.json',
                        width: 100,
                        height: 100,
                        animate: true,
                        repeat: true,
                        ),
              const SizedBox(height: 24),
              Text(
                'No transactions found',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your transaction history will appear here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    return RefreshIndicator(
      onRefresh: () async {
        _loadAllTransactions();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allTransactions.length,
        itemBuilder: (context, index) {
          final transaction = allTransactions[index];
          
          return Dismissible(
            key: Key(transaction.id),
            direction: DismissDirection.endToStart,
            background: Container(
              margin: const EdgeInsets.only(bottom: 12),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
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
                  ),
                ],
              ),
            ),
            confirmDismiss: (direction) async {
              return await _showDeleteConfirmation(transaction);
            },
            onDismissed: (direction) {
              _deleteTransaction(transaction.id);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
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
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(TransactionModel transaction) async {
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
}
