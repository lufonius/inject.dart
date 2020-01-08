import 'dart:convert';

import 'package:inject_generator/src/analyzer/utils.dart';
import 'package:inject_generator/src/source/symbol_path.dart';
import 'package:inject_generator/src/summary.dart';
import 'package:test/test.dart';

void main() {
  group('summarry json', () {
    setUp(() {});
    test('should convert factorySummary to json', (){
      var factorySummary = new FactorySummary(FactoryKind.constructor, new SymbolPath('package', 'path.dart', 'symbol')).toJson();
      var asJson = JsonEncoder.withIndent('  ').convert(factorySummary);
    });
  });
}