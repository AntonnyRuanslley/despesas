import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:despesas/models/transaction.dart';
import 'package:despesas/components/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSoma = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.day == weekDay.day;
        bool sameYear = recentTransaction[i].date.day == weekDay.day;

        if (sameDay && sameMonth && sameYear) {
          totalSoma += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E('pt-BR').format(weekDay)[0].toUpperCase()[0],
        'value': totalSoma,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupTransactions.fold(0.0, (soma, tr) {
      return soma += (tr['value']) as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    groupTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupTransactions.map((tr) {
          return Expanded(
            child: ChartBar(
              label: tr['day'].toString(),
              value: double.parse(tr['value'].toString()),
              percentage: _weekTotalValue == 0
                  ? 0
                  : double.parse(tr['value'].toString()) / _weekTotalValue,
            ),
          );
        }).toList(),
      ),
    );
  }
}
