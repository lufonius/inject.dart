main() {
  var container = Container();

  B b = container.b;
  B b1 = container.b;
  B b2 = container.b;

  A a = container.a;
  A a2 = container.a;
  A a3 = container.a;

  List<AbstrF> listF = container.f;

  print(b);
}

class NonGeneratedModule {
  // @Provide
  AbstrC customCFactory(AbstrE e) => C(e);
}

class Container {
  DependencyFactory factory = DependencyFactory();

  // here we have the typing, generated
  AbstrA get a => this.factory.getImplementation(AbstrA);
  AbstrB get b => this.factory.getImplementation(AbstrB);
  AbstrC get c => this.factory.getImplementation(AbstrC);
  AbstrD get d => this.factory.getImplementation(AbstrD);
  AbstrE get e => this.factory.getImplementation(AbstrE);
  List<AbstrF> get f => this.factory.getImplementations<AbstrF>(AbstrF);
}

class DependencyFactory {
  NonGeneratedModule module;

  Map<Type, dynamic> factories = {};
  Map<Type, dynamic> instantiationStrategiesPerType = {};
  Map<Type, List<dynamic>> instantiationStrategiesPerListType = {};
  Map<Type, dynamic> invocatedTypes = {};

  DependencyFactory() {
    this.module = NonGeneratedModule();

    this.factories = {
      AbstrA: () => A(getImplementation(AbstrB)), // the problem here is that we create a new instance everytime
      AbstrB: () => B(getImplementation(AbstrC), getImplementation(AbstrD)),
      AbstrC: () => this.module.customCFactory(getImplementation(AbstrE)),
      AbstrD: () => D(),
      AbstrE: () => E(),
      F: () => F(),
      F2: () => F2()
    };

    this.instantiationStrategiesPerType = {
      AbstrA: () => _getSingletonOfType(AbstrA),
      AbstrB: () => _getInstanceOfType(AbstrB),
      AbstrC: () => _getSingletonOfType(AbstrC),
      AbstrD: () => _getInstanceOfType(AbstrD),
      AbstrE: () => _getSingletonOfType(AbstrE),
      AbstrF: () => _getListOfType(AbstrF)
    };

    this.instantiationStrategiesPerListType = {
      AbstrF: [
            () => _getSingletonOfType(F),
            () => _getInstanceOfType(F2)
      ]
    };
  }

  dynamic getImplementation(Type type) {
    return this.instantiationStrategiesPerType[type]();
  }

  List<dynamic> getImplementations<T>(Type type) {
    return this.getImplementation(type).cast<T>();
  }

  _getInstanceOfType(Type type) {
    var instance = this.factories[type]();
    instance + 1;

    return instance;
  }

  _getSingletonOfType(Type type) {
    if (this.invocatedTypes.containsKey(type)) {
      return this.invocatedTypes[type];
    } else {
      var instance = this._getInstanceOfType(type);
      this.invocatedTypes[type] = instance;

      return instance;
    }
  }

  _getListOfType(Type type) {
    var implementationsTypeFactories = this.instantiationStrategiesPerListType[type];

    return implementationsTypeFactories
        .map((factory) => factory())
        .toList(growable: false);
  }
}

class InvocationCounter {

}

abstract class AbstrA {}
class A extends InvocationCounter implements AbstrA {
  final B bDependency;

  A(this.bDependency);

  static int _invocations = 0;
  @override
  operator +(int counter){
    _invocations = _invocations + counter;
  }

  static get invocations => _invocations;

  @override
  String toString() => '''
  Class A
  Dependencies: [
    B: ${this.bDependency}
  ]''';
}

abstract class AbstrB {}
class B extends InvocationCounter implements AbstrB {
  final C cDependency;
  final D dDependency;

  B(this.cDependency, this.dDependency);

  static int _invocations = 0;
  @override
  operator +(int counter){
    _invocations = _invocations + counter;
  }

  static get invocations => _invocations;

  @override
  String toString() => '''
  Class B
  Dependencies: [
    C: ${this.cDependency},
    D: ${this.dDependency}
  ]''';
}

abstract class AbstrC {}
class C extends InvocationCounter implements AbstrC {
  final E eDependency;

  C(this.eDependency);

  static int _invocations = 0;
  @override
  operator +(int counter){
    _invocations = _invocations + counter;
  }

  static get invocations => _invocations;

  @override
  String toString() => '''
  Class C
  Dependencies: [
    E: ${this.eDependency}
  ]''';
}

abstract class AbstrD {}
class D extends InvocationCounter implements AbstrD {
  static int _invocations = 0;
  @override
  operator +(int counter){
    _invocations = _invocations + counter;
  }

  static get invocations => _invocations;

  @override
  String toString() => '''
  Class D
    Dependencies: []
  ''';
}

abstract class AbstrE {}
class E extends InvocationCounter implements AbstrE {
  static int _invocations = 0;
  @override
  operator +(int counter){
    _invocations = _invocations + counter;
  }

  static get invocations => _invocations;

  @override
  String toString() => '''
  Class E
    Dependencies: []
  ''';
}

abstract class AbstrF {}
class F implements AbstrF {
  static int _invocations = 0;
  @override
  operator +(int counter){
    _invocations = _invocations + counter;
  }

  static get invocations => _invocations;
}

class F2 implements AbstrF {
  static int _invocations = 0;
  @override
  operator +(int counter){
    _invocations = _invocations + counter;
  }

  static get invocations => _invocations;
}