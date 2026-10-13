// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoctorsState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoctorsState()';
}


}

/// @nodoc
class $DoctorsStateCopyWith<$Res>  {
$DoctorsStateCopyWith(DoctorsState _, $Res Function(DoctorsState) __);
}


/// Adds pattern-matching-related methods to [DoctorsState].
extension DoctorsStatePatterns on DoctorsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Loading value)?  loading,TResult Function( EmptyState value)?  empty,TResult Function( Loaded value)?  loaded,TResult Function( ErrorState value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading(_that);case EmptyState() when empty != null:
return empty(_that);case Loaded() when loaded != null:
return loaded(_that);case ErrorState() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Loading value)  loading,required TResult Function( EmptyState value)  empty,required TResult Function( Loaded value)  loaded,required TResult Function( ErrorState value)  error,}){
final _that = this;
switch (_that) {
case Loading():
return loading(_that);case EmptyState():
return empty(_that);case Loaded():
return loaded(_that);case ErrorState():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Loading value)?  loading,TResult? Function( EmptyState value)?  empty,TResult? Function( Loaded value)?  loaded,TResult? Function( ErrorState value)?  error,}){
final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading(_that);case EmptyState() when empty != null:
return empty(_that);case Loaded() when loaded != null:
return loaded(_that);case ErrorState() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  empty,TResult Function( List<Doctor> doctors)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading();case EmptyState() when empty != null:
return empty();case Loaded() when loaded != null:
return loaded(_that.doctors);case ErrorState() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  empty,required TResult Function( List<Doctor> doctors)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case Loading():
return loading();case EmptyState():
return empty();case Loaded():
return loaded(_that.doctors);case ErrorState():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  empty,TResult? Function( List<Doctor> doctors)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading();case EmptyState() when empty != null:
return empty();case Loaded() when loaded != null:
return loaded(_that.doctors);case ErrorState() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Loading implements DoctorsState {
  const Loading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoctorsState.loading()';
}


}




/// @nodoc


class EmptyState implements DoctorsState {
  const EmptyState();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoctorsState.empty()';
}


}




/// @nodoc


class Loaded implements DoctorsState {
  const Loaded( List<Doctor> doctors): _doctors = doctors;
  

 final  List<Doctor> _doctors;
 List<Doctor> get doctors {
  if (_doctors is EqualUnmodifiableListView) return _doctors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doctors);
}


/// Create a copy of DoctorsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other.doctors, _doctors));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_doctors));
}

@override
String toString() {
    return 'DoctorsState.loaded(doctors: $doctors)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $DoctorsStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Doctor> doctors
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of DoctorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? doctors = null,}) {
  return _then(Loaded(
null == doctors ? _self._doctors : doctors // ignore: cast_nullable_to_non_nullable
as List<Doctor>,
  ));
}


}

/// @nodoc


class ErrorState implements DoctorsState {
  const ErrorState(this.message);
  

 final  String message;

/// Create a copy of DoctorsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorStateCopyWith<ErrorState> get copyWith => _$ErrorStateCopyWithImpl<ErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'DoctorsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorStateCopyWith<$Res> implements $DoctorsStateCopyWith<$Res> {
  factory $ErrorStateCopyWith(ErrorState value, $Res Function(ErrorState) _then) = _$ErrorStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorStateCopyWithImpl<$Res>
    implements $ErrorStateCopyWith<$Res> {
  _$ErrorStateCopyWithImpl(this._self, this._then);

  final ErrorState _self;
  final $Res Function(ErrorState) _then;

/// Create a copy of DoctorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorState(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
