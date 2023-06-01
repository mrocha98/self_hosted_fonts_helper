import 'dart:io';

Future<String> readModelFixture(String folder) async {
  final path = '${Directory.current.path}/test/src/models/$folder/fixture.json';
  return File(path).readAsString();
}
