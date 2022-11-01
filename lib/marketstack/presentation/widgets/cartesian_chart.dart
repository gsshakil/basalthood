import 'package:basalt_task/marketstack/data/model/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CartesianChart extends StatelessWidget {
  const CartesianChart({
    Key? key,
    required this.stockData,
  }) : super(key: key);

  final List<StockModel> stockData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SfCartesianChart(
        series: <CandleSeries>[
          CandleSeries<StockModel, DateTime>(
              dataSource: stockData,
              xValueMapper: (StockModel stock, _) =>
                  DateTime.tryParse(stock.date),
              lowValueMapper: (StockModel stock, _) => stock.low,
              highValueMapper: (StockModel stock, _) => stock.high,
              openValueMapper: (StockModel stock, _) => stock.open,
              closeValueMapper: (StockModel stock, _) => stock.close)
        ],
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 200,
          interval: 10,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
        ),
      ),
    );
  }
}
