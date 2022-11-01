import 'package:basalt_task/core/di.dart';
import 'package:basalt_task/core/internet_check_wrapper.dart';
import 'package:basalt_task/marketstack/presentation/blocs/ticker_bloc/ticker_bloc.dart';
import 'package:basalt_task/marketstack/presentation/screens/stock_screen.dart';
import 'package:basalt_task/marketstack/presentation/widgets/ticker_card.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tickerBloc = injector<TickerBloc>();
  final FocusNode _easyFocus = FocusNode();

  @override
  void initState() {
    _tickerBloc.add(GetTickerData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _tickerBloc,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            _easyFocus.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 200,
              flexibleSpace: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 0.9,
                  colors: [
                    Color.fromARGB(255, 255, 120, 117),
                    Colors.red,
                  ],
                )),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    'Real-Time & Historical Stock Data API',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<TickerBloc, TickerState>(
                    builder: (context, state) {
                      return Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: EasyAutocomplete(
                          focusNode: _easyFocus,
                          decoration: const InputDecoration(
                              hintText: 'Search..',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              suffixIcon: Icon(Icons.search)),
                          suggestions: state is TickerSuccess
                              ? state.tickerData.map((e) => e.symbol).toList()
                              : [],
                          onChanged: (value) {},
                          onSubmitted: (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StockScreen(symbol: value),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ),
            body: BlocBuilder<TickerBloc, TickerState>(
              builder: (context, state) {
                if (state is TickerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TickerError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.error),
                          ElevatedButton(
                              onPressed: () {
                                _tickerBloc.add(GetTickerData());
                              },
                              child: const Text('Retry'))
                        ],
                      ),
                    ),
                  );
                } else if (state is TickerSuccess) {
                  return InternetCheckWrapper(
                    child: RefreshIndicator(
                      onRefresh: () async => _tickerBloc.add(GetTickerData()),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.tickerData.length,
                          itemBuilder: (context, index) {
                            return TickerCard(
                              ticker: state.tickerData[index],
                            );
                          }),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
