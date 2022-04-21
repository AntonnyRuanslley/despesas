import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  value == 0
                      ? '0,00'
                      : NumberFormat('.00', 'pt-BR').format(value),
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.04),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 210, 67, 56),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.04),
            Container(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
