// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleState {

 bool get isAccountOwner; String get patientName; String get patientAge; Gender? get gender; DateTime? get selectedTime; ScheduleStatus get status; String? get message; int get formRevision;
/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleStateCopyWith<ScheduleState> get copyWith => _$ScheduleStateCopyWithImpl<ScheduleState>(this as ScheduleState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScheduleState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleState&&(identical(other.isAccountOwner, _this.isAccountOwner) || other.isAccountOwner == _this.isAccountOwner)&&(identical(other.patientName, _this.patientName) || other.patientName == _this.patientName)&&(identical(other.patientAge, _this.patientAge) || other.patientAge == _this.patientAge)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.selectedTime, _this.selectedTime) || other.selectedTime == _this.selectedTime)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.formRevision, _this.formRevision) || other.formRevision == _this.formRevision));
}


@override
int get hashCode {
  final _this = this as ScheduleState;
  return Object.hash(runtimeType,_this.isAccountOwner,_this.patientName,_this.patientAge,_this.gender,_this.selectedTime,_this.status,_this.message,_this.formRevision);
}

@override
String toString() {
  final _this = this as ScheduleState;
  return 'ScheduleState(isAccountOwner: ${_this.isAccountOwner}, patientName: ${_this.patientName}, patientAge: ${_this.patientAge}, gender: ${_this.gender}, selectedTime: ${_this.selectedTime}, status: ${_this.status}, message: ${_this.message}, formRevision: ${_this.formRevision})';
}


}

/// @nodoc
abstract mixin class $ScheduleStateCopyWith<$Res>  {
  factory $ScheduleStateCopyWith(ScheduleState value, $Res Function(ScheduleState) _then) = _$ScheduleStateCopyWithImpl;
@useResult
$Res call({
 bool isAccountOwner, String patientName, String patientAge, Gender? gender, DateTime? selectedTime, ScheduleStatus status, String? message, int formRevision
});




}
/// @nodoc
class _$ScheduleStateCopyWithImpl<$Res>
    implements $ScheduleStateCopyWith<$Res> {
  _$ScheduleStateCopyWithImpl(this._self, this._then);

  final ScheduleState _self;
  final $Res Function(ScheduleState) _then;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAccountOwner = null,Object? patientName = null,Object? patientAge = null,Object? gender = freezed,Object? selectedTime = freezed,Object? status = null,Object? message = freezed,Object? formRevision = null,}) {
  return _then(ScheduleState(
isAccountOwner: null == isAccountOwner ? _self.isAccountOwner : isAccountOwner // ignore: cast_nullable_to_non_nullable
as bool,patientName: null == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String,patientAge: null == patientAge ? _self.patientAge : patientAge // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScheduleStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,formRevision: null == formRevision ? _self.formRevision : formRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleState].
extension ScheduleStatePatterns on ScheduleState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleState value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleState value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAccountOwner,  String patientName,  String patientAge,  Gender? gender,  DateTime? selectedTime,  ScheduleStatus status,  String? message,  int formRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleState() when $default != null:
return $default(_that.isAccountOwner,_that.patientName,_that.patientAge,_that.gender,_that.selectedTime,_that.status,_that.message,_that.formRevision);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAccountOwner,  String patientName,  String patientAge,  Gender? gender,  DateTime? selectedTime,  ScheduleStatus status,  String? message,  int formRevision)  $default,) {final _that = this;
switch (_that) {
case _ScheduleState():
return $default(_that.isAccountOwner,_that.patientName,_that.patientAge,_that.gender,_that.selectedTime,_that.status,_that.message,_that.formRevision);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAccountOwner,  String patientName,  String patientAge,  Gender? gender,  DateTime? selectedTime,  ScheduleStatus status,  String? message,  int formRevision)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleState() when $default != null:
return $default(_that.isAccountOwner,_that.patientName,_that.patientAge,_that.gender,_that.selectedTime,_that.status,_that.message,_that.formRevision);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleState implements ScheduleState {
  const _ScheduleState({this.isAccountOwner = true, this.patientName = '', this.patientAge = '', this.gender, this.selectedTime, this.status = ScheduleStatus.initial, this.message, this.formRevision = 0});
  

@override@JsonKey() final  bool isAccountOwner;
@override@JsonKey() final  String patientName;
@override@JsonKey() final  String patientAge;
@override final  Gender? gender;
@override final  DateTime? selectedTime;
@override@JsonKey() final  ScheduleStatus status;
@override final  String? message;
@override@JsonKey() final  int formRevision;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleStateCopyWith<_ScheduleState> get copyWith => __$ScheduleStateCopyWithImpl<_ScheduleState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleState&&(identical(other.isAccountOwner, isAccountOwner) || other.isAccountOwner == isAccountOwner)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.patientAge, patientAge) || other.patientAge == patientAge)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.formRevision, formRevision) || other.formRevision == formRevision));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isAccountOwner,patientName,patientAge,gender,selectedTime,status,message,formRevision);
}

@override
String toString() {
    return 'ScheduleState(isAccountOwner: $isAccountOwner, patientName: $patientName, patientAge: $patientAge, gender: $gender, selectedTime: $selectedTime, status: $status, message: $message, formRevision: $formRevision)';
}


}

/// @nodoc
abstract mixin class _$ScheduleStateCopyWith<$Res> implements $ScheduleStateCopyWith<$Res> {
  factory _$ScheduleStateCopyWith(_ScheduleState value, $Res Function(_ScheduleState) _then) = __$ScheduleStateCopyWithImpl;
@override @useResult
$Res call({
 bool isAccountOwner, String patientName, String patientAge, Gender? gender, DateTime? selectedTime, ScheduleStatus status, String? message, int formRevision
});




}
/// @nodoc
class __$ScheduleStateCopyWithImpl<$Res>
    implements _$ScheduleStateCopyWith<$Res> {
  __$ScheduleStateCopyWithImpl(this._self, this._then);

  final _ScheduleState _self;
  final $Res Function(_ScheduleState) _then;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAccountOwner = null,Object? patientName = null,Object? patientAge = null,Object? gender = freezed,Object? selectedTime = freezed,Object? status = null,Object? message = freezed,Object? formRevision = null,}) {
  return _then(_ScheduleState(
isAccountOwner: null == isAccountOwner ? _self.isAccountOwner : isAccountOwner // ignore: cast_nullable_to_non_nullable
as bool,patientName: null == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String,patientAge: null == patientAge ? _self.patientAge : patientAge // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScheduleStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,formRevision: null == formRevision ? _self.formRevision : formRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
