// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of inject.src.summary;

/// The kind of provider.
enum ProviderKind {
  /// The provider is implemented as a constructor or a `factory`.
  constructor,

  /// The provider is implemented as a method.
  method,

  /// The provider is implemented as a getter.
  getter,
}

/// Maps between [ProviderKind] enum values and their names.
final _providerKindNames = new BiMap<ProviderKind, String>()
  ..[ProviderKind.constructor] = 'constructor'
  ..[ProviderKind.method] = 'method'
  ..[ProviderKind.getter] = 'getter';

/// Converts provider [name] to the corresponding `enum` reference.
ProviderKind providerKindFromName(String name) {
  ProviderKind kind = _providerKindNames.inverse[name];

  if (kind == null) {
    throw new ArgumentError.value(name, 'name', 'Invalid provider kind name');
  }

  return kind;
}

/// Converts a provider [kind] to its name.
///
/// See also [providerKindFromName].
String provideKindName(ProviderKind kind) {
  String name = _providerKindNames[kind];

  if (name == null) {
    throw new ArgumentError.value(kind, 'kind', 'Unrecognized provider kind');
  }

  return name;
}

/// Contains information about a method, constructor, factory or a getter
/// annotated with `@provide`.
class ProviderSummary {
  final String name;
  final ProviderKind kind;
  final LookupKey implementationClass;
  final LookupKey abstractionClass;
  final FactorySummary factorySummary;
  final bool isMultiple;
  final bool isSingleton;
  final bool isAsynchronous;
  final List<InjectedType> dependencies;

factory ProviderSummary(
    String name,
    ProviderKind kind,
    LookupKey implementationClass,
    LookupKey abstractionClass,
    FactorySummary factorySummary, {
    List<InjectedType> dependencies: const [],
    bool multiple: false,
    bool singleton: false,
    bool asynchronous: false
  }) {
    if (factorySummary == null) {
      throw new ArgumentError.notNull('lookupKey');
    }
    if (name == null) {
      throw new ArgumentError.notNull('name');
    }
    if (kind == null) {
      throw new ArgumentError.notNull('providerKind');
    }
    if (dependencies == null) {
      throw new ArgumentError.notNull('dependencies');
    }
    if (singleton == null) {
      throw new ArgumentError.notNull('singleton');
    }
    if (multiple == null) {
      throw new ArgumentError.notNull('singleton');
    }
    if (asynchronous && kind != ProviderKind.method) {
      throw new ArgumentError(
          'Only methods can be asynchronous providers but found $kind $name.');
    }
    return new ProviderSummary._(
      name,
      kind,
      implementationClass,
      abstractionClass,
      factorySummary,
      multiple,
      singleton,
      asynchronous,
      new List<InjectedType>.unmodifiable(dependencies),
    );
  }

  ProviderSummary._(
    this.name,
    this.kind,
    this.implementationClass,
    this.abstractionClass,
    this.factorySummary,
    this.isMultiple,
    this.isSingleton,
    this.isAsynchronous,
    this.dependencies,
  );

  /// Serializes this summary to JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'kind': provideKindName(kind),
      'implementationClass': implementationClass,
      'abstractionClass': abstractionClass,
      'factorySummary': factorySummary,
      'multiple': isMultiple,
      'singleton': isSingleton,
      'asynchronous': isAsynchronous,
      'dependencies': dependencies
    };
  }

  @override
  String toString() =>
      '$ProviderSummary ' +
      {
        'name': name,
        'kind': kind,
        'implementationClass': implementationClass,
        'abstractionClass': abstractionClass,
        'factory': factorySummary,
        'multiple': isMultiple,
        'singleton': isSingleton,
        'asynchronous': isAsynchronous,
        'dependencies': dependencies
      }.toString();
}
