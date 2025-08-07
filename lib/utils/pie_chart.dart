import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/services/hive_services.dart';

class PieChartTotal extends StatefulWidget {
  const PieChartTotal({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartTotal> {
  int touchedIndex = -1;

  double totalIncome = 0.0;
  double totalExpenses = 0.0;
  double totalBalance = 0.0;

  @override
  void initState(){
    super.initState();
    _loadData();
  }

  void _loadData(){
    setState(() {
      totalIncome = HiveService.getIncome();
      totalExpenses = HiveService.getExpense();
      totalBalance = HiveService.getBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.6,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  sections: showingSections(),
                  
                ),
                
              ),
                              
            ),
            
          ),
          
          


          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
        ],
      ),
    ]));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 30.0 : 20.0;
      final radius = isTouched ? 80.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];


     // logic for getting percentage 
      double remainingIncome = totalIncome - totalExpenses;
      if(remainingIncome < 0) remainingIncome =0;

      double expensePercentage = totalIncome > 0 ? (totalExpenses/totalIncome) *100 :0;
      double remainingPercentage = 100 - expensePercentage;

      if(expensePercentage>100){
        expensePercentage = 100;
        remainingPercentage = 0;
      }

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color.fromRGBO(235, 167, 91, 1),
            value: expensePercentage,
            title: '${expensePercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Color.fromRGBO(156, 74, 255, 1),
            value: remainingPercentage,
            title: '${remainingPercentage.toStringAsFixed(1)} %',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
            borderRadius: isSquare ? BorderRadius.circular(3) : null,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.black87,
          ),
        )
      ],
    );
  }
}

