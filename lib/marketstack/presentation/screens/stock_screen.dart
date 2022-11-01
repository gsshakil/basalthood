import 'package:basalt_task/core/di.dart';
import 'package:basalt_task/core/internet_check_wrapper.dart';
import 'package:basalt_task/marketstack/data/model/stock_model.dart';
import 'package:basalt_task/marketstack/presentation/blocs/date_range_bloc/date_range_bloc.dart';
import 'package:basalt_task/marketstack/presentation/blocs/stock_bloc/stock_bloc.dart';
import 'package:basalt_task/marketstack/presentation/widgets/cartesian_chart.dart';
import 'package:basalt_task/marketstack/presentation/widgets/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key, required this.symbol});

  final String symbol;

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final _stockBloc = injector<StockBloc>();
  final _dateRangeBloc = injector<DateRangeBloc>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _stockBloc.add(GetStockData(
      dateFrom: DateFormat('yyyy-MM-dd').format(_dateRangeBloc.dateRange.start),
      dateTo: DateFormat('yyyy-MM-dd').format(_dateRangeBloc.dateRange.end),
      symbol: widget.symbol,
    ));
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _stockBloc.add(GetMoreStockData(
            dateFrom:
                DateFormat('yyyy-MM-dd').format(_dateRangeBloc.dateRange.start),
            dateTo:
                DateFormat('yyyy-MM-dd').format(_dateRangeBloc.dateRange.end),
            symbol: widget.symbol,
          ));
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: _dateRangeBloc.dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2023),
    );
    if (newDateRange == null) return;
    _dateRangeBloc.add(SetDateRange(dateRange: newDateRange));
    _stockBloc.add(GetStockData(
      dateFrom: DateFormat('yyyy-MM-dd').format(_dateRangeBloc.dateRange.start),
      dateTo: DateFormat('yyyy-MM-dd').format(_dateRangeBloc.dateRange.end),
      symbol: widget.symbol,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _stockBloc),
        BlocProvider.value(value: _dateRangeBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.symbol),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: BlocBuilder<DateRangeBloc, DateRangeState>(
              builder: (context, state) {
                return Card(
                  margin: const EdgeInsets.all(0),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: MaterialButton(
                        onPressed: pickDateRange,
                        child: Row(
                          children: [
                            const Icon(Icons.date_range),
                            const SizedBox(width: 10),
                            Text(DateFormat('yyyy/MM/dd')
                                .format(_dateRangeBloc.dateRange.start)),
                          ],
                        ),
                      )),
                      const Text('to'),
                      Expanded(
                          child: MaterialButton(
                        onPressed: pickDateRange,
                        child: Row(
                          children: [
                            const Icon(Icons.date_range),
                            const SizedBox(width: 10),
                            Text(DateFormat('yyyy/MM/dd')
                                .format(_dateRangeBloc.dateRange.end)),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        body: InternetCheckWrapper(
          child: BlocBuilder(
            bloc: _stockBloc,
            builder: (context, state) {
              if (state is StockLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is StockError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error),
                        ElevatedButton(
                            onPressed: () {
                              _stockBloc.add(
                                GetStockData(
                                  dateFrom: DateFormat('yyyy-MM-dd')
                                      .format(_dateRangeBloc.dateRange.start),
                                  dateTo: DateFormat('yyyy-MM-dd')
                                      .format(_dateRangeBloc.dateRange.end),
                                  symbol: widget.symbol,
                                ),
                              );
                            },
                            child: const Text('Retry'))
                      ],
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async => _stockBloc
                  ..add(
                    GetStockData(
                      dateFrom: DateFormat('yyyy-MM-dd')
                          .format(_dateRangeBloc.dateRange.start),
                      dateTo: DateFormat('yyyy-MM-dd')
                          .format(_dateRangeBloc.dateRange.end),
                      symbol: widget.symbol,
                    ),
                  ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Chart
                      CartesianChart(stockData: _stockBloc.getStockData),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _stockBloc.getStockData.isEmpty
                            ? 1
                            : _stockBloc.getStockData.length,
                        itemBuilder: (context, index) {
                          if (state is StockMoreLoading) {
                            if ((index == _stockBloc.getStockData.length - 1) &&
                                _stockBloc.getStockData.length <
                                    _stockBloc.stockPaginationModel.pagination
                                        .total) {
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          }

                          return _stockBloc.getStockData.isEmpty
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text('Nothing Found'),
                                  ),
                                )
                              : StockCard(
                                  stock: _stockBloc.getStockData[index],
                                );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
