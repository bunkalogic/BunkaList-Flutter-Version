import 'dart:io';

String fixture(String name) => File('test/src/fixtures/$name').readAsStringSync();