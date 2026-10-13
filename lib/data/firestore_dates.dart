import 'package:cloud_firestore/cloud_firestore.dart';

DateTime readTimestamp(Object? value) {
  if (value is Timestamp) return value.toDate().toUtc();
  if (value is DateTime) return value.toUtc();
  throw const FormatException('Expected a Firestore Timestamp');
}

String dateOnly(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';
