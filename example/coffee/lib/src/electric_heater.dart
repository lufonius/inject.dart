// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:inject/inject.dart';

import 'heater.dart';

@Provide(Heater)
@singleton
class ElectricHeater implements Heater {

  bool _heating = false;

  @override
  void on() {
    print('heating');
    _heating = true;
  }

  @override
  void off() {
    _heating = false;
  }

  @override
  bool get isHot => _heating;
}
