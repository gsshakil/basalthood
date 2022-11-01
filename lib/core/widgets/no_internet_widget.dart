import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.wifi_off,
          size: 100,
        ),
        const SizedBox(height: 10),
        Text(
          'No Internet',
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    ));
  }
}
