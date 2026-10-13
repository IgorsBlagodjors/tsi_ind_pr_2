import 'dart:convert';
import 'dart:io';

import '../lib/data/doctors/doctors.dart';

void main() {
  final ids = <String>{};
  final records = doctors.map((doctor) {
    if (doctor.id.isEmpty || doctor.id.contains('/') || !ids.add(doctor.id)) {
      throw StateError('Invalid or duplicate doctor ID: ${doctor.id}');
    }
    return {'id': doctor.id, 'data': doctor.toMap()};
  }).toList();
  final output = File('tool/doctors.seed.json');
  output.writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(records)}\n');
  stdout.writeln('Exported ${records.length} doctors to ${output.path}');
}
