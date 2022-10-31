import 'package:basalt_task/env/env.dart';

class APIEndPoints {
  static String stockEndPoint =
      'http://api.marketstack.com/v1/eod?access_key=${Env.marketStackApiKey}';
}
