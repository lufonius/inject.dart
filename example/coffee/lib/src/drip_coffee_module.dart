// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:inject.example.coffee/src/dartiello_tank.dart';
import 'package:inject.example.coffee/src/tank.dart';
import 'package:inject/inject.dart';

import 'electric_heater.dart';
import 'heater.dart';
import 'liquid.dart';
import 'pump.dart';
import 'thermosiphon.dart';

// Examples of a named/qualified globally scoped token for injection.
const brandName = const Qualifier(#brandName);
const modelName = const Qualifier(#modelName);

/// Provides various objects to create a drip coffee brewer.
@module
class DripCoffeeModule {
  /// An example of a provider that uses a [Qualifier].
  @provide
  @brandName
  String provideBrand() => 'Coffee by Dart Inc.';

  /// Also a qualified provider.
  ///
  /// Just like [provideBrand], it also returns a `String`. The qualifier
  /// `modelName` is used to distinguish between this provider and
  /// [provideBrand].
  @provide
  @modelName
  String provideModel() => 'DripCoffeeStandard';

  @Provide(Tank)
  @multiple
  Tank getDartielloTank(Liquid liquid) {
    return DartielloTank(liquid);
  }
}
