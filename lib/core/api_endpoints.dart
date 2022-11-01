import 'package:basalt_task/core/env/env.dart';

class APIEndPoints {
  static String stockEndPoint =
      'http://api.marketstack.com/v1/eod?access_key=${Env.marketStackApiKey}';

  static String tickersEndPoint =
      'http://api.marketstack.com/v1/tickers?access_key=${Env.marketStackApiKey}&limit=10';
}
