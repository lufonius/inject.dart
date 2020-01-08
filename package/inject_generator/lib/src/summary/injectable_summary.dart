// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of inject.src.summary;

class InjectableSummary {
  final SymbolPath clazz;

  final ProviderSummary provider;

  factory InjectableSummary(SymbolPath clazz, ProviderSummary constructor) {
    if (clazz == null) {
      throw new ArgumentError.notNull('clazz');
    }
    if (constructor == null) {
      throw new ArgumentError.value(
          constructor, 'constructor', 'Must not be null');
    }
    return new InjectableSummary._(clazz, constructor);
  }

  InjectableSummary._(this.clazz, this.provider);

  Map<String, dynamic> toJson() {
    return {'name': clazz.symbol, 'provider': provider};
  }

  @override
  String toString() =>
      '$InjectableSummary ' +
      {'clazz': clazz, 'constructor': provider}.toString();
}
