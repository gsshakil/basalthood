import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'MARKETSTACK_KEY', obfuscate: true)
  static final marketStackApiKey = _Env.marketStackApiKey;
}
