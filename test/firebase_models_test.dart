import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_booking.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_status.dart';
import 'package:tsi_ind_pr_2/data/demo/demo_data.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/reviews/doctor_review.dart';
import 'package:tsi_ind_pr_2/data/schedule/doctor_slot.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';

void main() {
  final now = DateTime.utc(2026, 12, 31, 23);
  final demo = DemoData(now: now);

  test(
    'Each booking links to an existing user, doctor and matching time slot',
    () {
      final bookedSlots = <String>{};
      for (final booking in demo.appointments) {
        expect(demo.users.any((user) => user.id == booking.userId), isTrue);
        expect(demo.doctorById(booking.doctorId).id, booking.doctorId);
        final slot = demo.slots.singleWhere(
          (slot) => slot.id == booking.slotId,
        );
        expect(slot.doctorId, booking.doctorId);
        expect(slot.startsAt, booking.startsAt);
        expect(slot.endsAt.isAfter(slot.startsAt), isTrue);
        expect(booking.createdAt.isBefore(booking.startsAt), isTrue);
        if (booking.status != AppointmentStatus.cancelled) {
          expect(bookedSlots.add(slot.id), isTrue);
          expect(slot.status, DoctorSlotStatus.booked);
        } else {
          expect(slot.status, DoctorSlotStatus.available);
        }
      }
      final mine = demo.appointmentsFor(
        demo.currentUser.id,
        AppointmentStatus.upcoming,
      );
      expect(mine, hasLength(1));
      expect(mine.single.patient.isAccountOwner, isFalse);
      expect(mine.single.startsAt.isAfter(now), isTrue);
      expect(mine.single.startsAt.year, 2027);
    },
  );

  test('Firestore round-trip keeps timestamps, patient and enum values', () {
    for (final booking in demo.appointments) {
      final data = booking.toMap();
      expect(data['startsAt'], isA<Timestamp>());
      expect(data['status'], isA<String>());
      expect(data.containsKey('id'), isFalse);
      final restored = AppointmentBooking.fromMap(booking.id, data);
      expect(restored.toMap(), data);
      expect(restored.startsAt.isUtc, isTrue);
    }
    for (final slot in demo.slots) {
      expect(DoctorSlot.fromMap(slot.id, slot.toMap()).toMap(), slot.toMap());
      expect(slot.toMap().containsKey('patient'), isFalse);
    }
    expect(demo.slots.any((slot) => slot.isAvailableAt(now)), isTrue);
    expect(
      demo.slots.every(
        (slot) => !slot.isAvailableAt(now.add(const Duration(days: 30))),
      ),
      isTrue,
    );
  });

  test(
    'User date of birth remains a calendar date and favorites stay per user',
    () {
      for (final user in demo.users) {
        final data = user.toMap();
        expect(data['dateOfBirth'], matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));
        expect(data.containsKey('password'), isFalse);
        expect(AppUser.fromMap(user.id, data).toMap(), data);
        expect(demo.favoritesFor(user).length, user.favoriteDoctorIds.length);
      }
      expect(
        demo.favoritesFor(demo.users[0]).map((d) => d.id),
        isNot(contains(demo.favoritesFor(demo.users[1]).single.id)),
      );
    },
  );

  test('Doctor serialization does not publish personal favorite state', () {
    for (final doctor in demo.allDoctors) {
      expect(Doctor.fromMap(doctor.id, doctor.toMap()).toMap(), doctor.toMap());
      expect(doctor.toMap().containsKey('isFavorite'), isFalse);
    }
    final data = demo.allDoctors.first.toMap()..['rating'] = 5;
    expect(Doctor.fromMap('numeric-rating', data).rating, 5.0);
  });

  test(
    'Reviews refer to completed appointments and match the doctor summary',
    () {
      for (final review in demo.reviews) {
        final booking = demo.appointments.singleWhere(
          (a) => a.id == review.appointmentId,
        );
        expect(booking.status, AppointmentStatus.completed);
        expect(review.userId, booking.userId);
        expect(review.doctorId, booking.doctorId);
        expect(review.createdAt.isAfter(booking.endsAt), isTrue);
        expect(review.rating, inInclusiveRange(1, 5));
        expect(
          DoctorReview.fromMap(review.id, review.toMap()).toMap(),
          review.toMap(),
        );
      }
      final doctor = demo.doctorById('daniel-rodriguez');
      expect(doctor.reviewCount, demo.reviews.length);
      expect(doctor.rating, demo.reviews.single.rating.toDouble());
    },
  );
}
