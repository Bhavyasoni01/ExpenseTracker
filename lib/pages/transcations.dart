import 'package:flutter/material.dart';

class TranscationsBuild extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final String title;
  final String date;
  final String amount;
  final bool isExpense;



  const TranscationsBuild({super.key,
  required this.icon,
  required this.iconColor,
  required this.title,
  required this.date,
  required this.amount,
  required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(icon,
          width: 50,
          height: 40,
          fit: BoxFit.contain,
          errorBuilder:(context, error, stackTrace) {
            return Icon(
              Icons.account_balance_wallet_rounded,
              size: 24,
              color: Colors.grey[600],
            );
          },
)
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
               SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        
        Text(
          '${isExpense ? '-' : '+'}$amount',
          style: TextStyle(
            color: isExpense ? Colors.red : Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    )
    );
  }
}