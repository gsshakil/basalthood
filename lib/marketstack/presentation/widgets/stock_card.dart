import 'package:basalt_task/marketstack/data/model/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockCard extends StatelessWidget {
  const StockCard({
    Key? key,
    required this.stock,
  }) : super(key: key);

  final StockModel stock;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.symbol,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 5),
              Text(
                stock.exchange,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Open: ${stock.open.toString()}',
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(height: 5),
              Text('Close: ${stock.close.toString()}',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
          Text(DateFormat('yyyy-MM-dd').format(DateTime.tryParse(stock.date)!),
              style: Theme.of(context).textTheme.bodyText1),
        ]),
      ),
    );
  }
}
