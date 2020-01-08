import 'package:inject.example.coffee/src/tank.dart';
import 'package:inject/inject.dart';

import 'liquid.dart';

class DartielloTank implements Tank {
  final Liquid liquid;
  DartielloTank(this.liquid);

  @override
  int size() {
    return 60;
  }

}
