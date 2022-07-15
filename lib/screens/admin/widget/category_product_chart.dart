import 'package:amazon_clone/models/admin/sales.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CategoryProductChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;

  const CategoryProductChart({
    Key? key, 
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}