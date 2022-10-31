import 'dart:developer';

import 'package:basalt_task/core/di.dart';
import 'package:basalt_task/marketstack/presentation/stock_bloc/stock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _stockBloc = injector<StockBloc>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _stockBloc.add(GetStockData());
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _stockBloc.add(GetMoreStockData());
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _stockBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BASALTHOOD'),
          centerTitle: true,
        ),
        body: BlocConsumer<StockBloc, StockState>(
          listener: (context, state) {
            if (state is StockSuccess) {
              log('State is $state');
            }
          },
          builder: (context, state) {
            if (state is StockLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StockError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(state.error),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => _stockBloc..add(GetStockData()),
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _stockBloc.getStockData().isEmpty
                      ? 1
                      : _stockBloc.getStockData().length,
                  itemBuilder: (context, index) {
                    if (state is StockMoreLoading) {
                      if ((index == _stockBloc.getStockData().length - 1) &&
                          _stockBloc.getStockData().length <
                              _stockBloc
                                  .stockPaginationModel.pagination.total) {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }

                    return _stockBloc.getStockData().isEmpty
                        ? const Center(child: Text('Nothing Found'))
                        : Card(
                            child: ListTile(
                                leading: Text(
                                    _stockBloc.getStockData()[index].symbol),
                                title: Text(_stockBloc
                                    .getStockData()[index]
                                    .open
                                    .toString())),
                          );
                  }),
            );
          },
        ),
      ),
    );
  }
}
