// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of inject.src.summary;

enum FactoryKind {
  constructor,
  method,
  getter
}

final _factoryKindNames = new BiMap<FactoryKind, String>()
  ..[FactoryKind.constructor] = 'constructor'
  ..[FactoryKind.method] = 'method'
  ..[FactoryKind.getter] = 'getter';

FactoryKind factoryKindFromName(String name) {
  FactoryKind kind = _factoryKindNames.inverse[name];

  if (kind == null) {
    throw new ArgumentError.value(name, 'name', 'Invalid provider kind name');
  }

  return kind;
}

String factoryKindNameFromKind(FactoryKind kind) {
  String name = _factoryKindNames[kind];

  if (name == null) {
    throw new ArgumentError.value(kind, 'kind', 'Unrecognized provider kind');
  }

  return name;
}


/// contains informations about how the provider is being built.
class FactorySummary {
  final FactoryKind kind;

  // dunno if a symbolpath can be used to describe a method
  final SymbolPath factoryImplementationPath;

  final bool isCustom;

  factory FactorySummary(
      FactoryKind kind,
      SymbolPath factoryImplementationPath,
      {
        isCustom = false
      }
    ) {
    return new FactorySummary._(
      kind,
      factoryImplementationPath,
      isCustom
    );
  }

  FactorySummary._(this.kind, this.factoryImplementationPath, this.isCustom);

  @override
  Map<String, dynamic> toJson() {
    return {
      'kind': factoryKindNameFromKind(this.kind),
      'factoryImplementationPath': this.factoryImplementationPath,
      'custom': isCustom
    };
  }

  @override
  String toString() =>
      '$FactorySummary() ' +
          {
            'kind': factoryKindNameFromKind(this.kind),
            'factoryImplementationPath': this.factoryImplementationPath,
            'custom': isCustom
          }.toString();
}
