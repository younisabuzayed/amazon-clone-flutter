import 'package:amazon_clone/data/apis/admin_api.dart';
import 'package:amazon_clone/models/admin/sales.dart';
import 'package:amazon_clone/screens/admin/widget/category_product_chart.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {

  final AdminAPI _adminAPI = AdminAPI();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState()
  {
    super.initState();
    getEarnings();
  }

  getEarnings() async
  {
    var earningData = await _adminAPI.getEarnings(context);
    totalSales = earningData['totalEarning'];
    earnings = earningData['sales'];
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
    ? const Loader()
    : Column(
      children: [
        Text(
          '\$$totalSales',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: CategoryProductChart(
            seriesList: [
            charts.Series(
              id: 'Sales', 
              data: earnings!, 
              domainFn: (Sales sales, _) => sales.label, 
              measureFn: (Sales sales, _) => sales.earning,
            ),
          ]),
        )
      ],
    );
  }
}