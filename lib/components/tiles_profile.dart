import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TilesProfile extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const TilesProfile({super.key,
  required this.icon,
  required this.title,
  required this.subtitle,
  required this.onTap
  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 08,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.deepPurple,
            size: 24,
          ),
        ),
        title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16
        ),),
        subtitle: Text(subtitle,
        style: TextStyle(
          color: Colors.grey[600],
        ),),
        trailing: Icon(CupertinoIcons.chevron_right,
        size: 20,),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        
        
      ),
    );
  }
}