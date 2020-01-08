import 'package:inject.example.coffee/src/tank.dart';
import 'package:inject/inject.dart';

import 'liquid.dart';

@Provide(Tank)
@multiple
class NespressoTank implements Tank {
  final Liquid liquid;
  NespressoTank(this.liquid);

  @override
  int size() {
    return 50;
  }
}