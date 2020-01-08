// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:inject/inject.dart';

import 'drip_coffee_module.dart';
import 'heater.dart';
import 'pump.dart';

@Provide(CoffeeMaker)
class NespressoCoffeeMaker implements CoffeeMaker {
  final Heater _heater;

  @modelName
  final String _model;

  @brandName
  final String _brand;

  NespressoCoffeeMaker(this._heater, this._brand, this._model);

  void brew() {
    _heater.on();
   // _pump.pump();
    print(' [_]P coffee! [_]P');
    print(' Thanks for using $_model by $_brand');
    _heater.off();
  }
}

abstract class CoffeeMaker {
  void brew();
}
