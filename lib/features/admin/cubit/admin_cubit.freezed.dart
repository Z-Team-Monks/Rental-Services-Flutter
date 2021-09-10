// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'admin_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AdminStateTearOff {
  const _$AdminStateTearOff();

  _Initial initial(List<Property> properties) {
    return _Initial(
      properties,
    );
  }

  _FetchingPosts fetchingPosts() {
    return const _FetchingPosts();
  }

  _PostFetchSuccess postFetchSuccess(List<Property> properties) {
    return _PostFetchSuccess(
      properties,
    );
  }

  _PostFetchFailure postFetchFailure(String errorMessage) {
    return _PostFetchFailure(
      errorMessage,
    );
  }

  _RejectApproveOk rejectApproveOk() {
    return const _RejectApproveOk();
  }

  _RejectApproveError rejectApproveError(String errorMessage) {
    return _RejectApproveError(
      errorMessage,
    );
  }
}

/// @nodoc
const $AdminState = _$AdminStateTearOff();

/// @nodoc
mixin _$AdminState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Property> properties) initial,
    required TResult Function() fetchingPosts,
    required TResult Function(List<Property> properties) postFetchSuccess,
    required TResult Function(String errorMessage) postFetchFailure,
    required TResult Function() rejectApproveOk,
    required TResult Function(String errorMessage) rejectApproveError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Property> properties)? initial,
    TResult Function()? fetchingPosts,
    TResult Function(List<Property> properties)? postFetchSuccess,
    TResult Function(String errorMessage)? postFetchFailure,
    TResult Function()? rejectApproveOk,
    TResult Function(String errorMessage)? rejectApproveError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingPosts value) fetchingPosts,
    required TResult Function(_PostFetchSuccess value) postFetchSuccess,
    required TResult Function(_PostFetchFailure value) postFetchFailure,
    required TResult Function(_RejectApproveOk value) rejectApproveOk,
    required TResult Function(_RejectApproveError value) rejectApproveError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingPosts value)? fetchingPosts,
    TResult Function(_PostFetchSuccess value)? postFetchSuccess,
    TResult Function(_PostFetchFailure value)? postFetchFailure,
    TResult Function(_RejectApproveOk value)? rejectApproveOk,
    TResult Function(_RejectApproveError value)? rejectApproveError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminStateCopyWith<$Res> {
  factory $AdminStateCopyWith(
          AdminState value, $Res Function(AdminState) then) =
      _$AdminStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AdminStateCopyWithImpl<$Res> implements $AdminStateCopyWith<$Res> {
  _$AdminStateCopyWithImpl(this._value, this._then);

  final AdminState _value;
  // ignore: unused_field
  final $Res Function(AdminState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  $Res call({List<Property> properties});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$AdminStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? properties = freezed,
  }) {
    return _then(_Initial(
      properties == freezed
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(this.properties);

  @override
  final List<Property> properties;

  @override
  String toString() {
    return 'AdminState.initial(properties: $properties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Initial &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(properties);

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Property> properties) initial,
    required TResult Function() fetchingPosts,
    required TResult Function(List<Property> properties) postFetchSuccess,
    required TResult Function(String errorMessage) postFetchFailure,
    required TResult Function() rejectApproveOk,
    required TResult Function(String errorMessage) rejectApproveError,
  }) {
    return initial(properties);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Property> properties)? initial,
    TResult Function()? fetchingPosts,
    TResult Function(List<Property> properties)? postFetchSuccess,
    TResult Function(String errorMessage)? postFetchFailure,
    TResult Function()? rejectApproveOk,
    TResult Function(String errorMessage)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(properties);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingPosts value) fetchingPosts,
    required TResult Function(_PostFetchSuccess value) postFetchSuccess,
    required TResult Function(_PostFetchFailure value) postFetchFailure,
    required TResult Function(_RejectApproveOk value) rejectApproveOk,
    required TResult Function(_RejectApproveError value) rejectApproveError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingPosts value)? fetchingPosts,
    TResult Function(_PostFetchSuccess value)? postFetchSuccess,
    TResult Function(_PostFetchFailure value)? postFetchFailure,
    TResult Function(_RejectApproveOk value)? rejectApproveOk,
    TResult Function(_RejectApproveError value)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AdminState {
  const factory _Initial(List<Property> properties) = _$_Initial;

  List<Property> get properties => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FetchingPostsCopyWith<$Res> {
  factory _$FetchingPostsCopyWith(
          _FetchingPosts value, $Res Function(_FetchingPosts) then) =
      __$FetchingPostsCopyWithImpl<$Res>;
}

/// @nodoc
class __$FetchingPostsCopyWithImpl<$Res> extends _$AdminStateCopyWithImpl<$Res>
    implements _$FetchingPostsCopyWith<$Res> {
  __$FetchingPostsCopyWithImpl(
      _FetchingPosts _value, $Res Function(_FetchingPosts) _then)
      : super(_value, (v) => _then(v as _FetchingPosts));

  @override
  _FetchingPosts get _value => super._value as _FetchingPosts;
}

/// @nodoc

class _$_FetchingPosts implements _FetchingPosts {
  const _$_FetchingPosts();

  @override
  String toString() {
    return 'AdminState.fetchingPosts()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _FetchingPosts);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Property> properties) initial,
    required TResult Function() fetchingPosts,
    required TResult Function(List<Property> properties) postFetchSuccess,
    required TResult Function(String errorMessage) postFetchFailure,
    required TResult Function() rejectApproveOk,
    required TResult Function(String errorMessage) rejectApproveError,
  }) {
    return fetchingPosts();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Property> properties)? initial,
    TResult Function()? fetchingPosts,
    TResult Function(List<Property> properties)? postFetchSuccess,
    TResult Function(String errorMessage)? postFetchFailure,
    TResult Function()? rejectApproveOk,
    TResult Function(String errorMessage)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (fetchingPosts != null) {
      return fetchingPosts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingPosts value) fetchingPosts,
    required TResult Function(_PostFetchSuccess value) postFetchSuccess,
    required TResult Function(_PostFetchFailure value) postFetchFailure,
    required TResult Function(_RejectApproveOk value) rejectApproveOk,
    required TResult Function(_RejectApproveError value) rejectApproveError,
  }) {
    return fetchingPosts(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingPosts value)? fetchingPosts,
    TResult Function(_PostFetchSuccess value)? postFetchSuccess,
    TResult Function(_PostFetchFailure value)? postFetchFailure,
    TResult Function(_RejectApproveOk value)? rejectApproveOk,
    TResult Function(_RejectApproveError value)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (fetchingPosts != null) {
      return fetchingPosts(this);
    }
    return orElse();
  }
}

abstract class _FetchingPosts implements AdminState {
  const factory _FetchingPosts() = _$_FetchingPosts;
}

/// @nodoc
abstract class _$PostFetchSuccessCopyWith<$Res> {
  factory _$PostFetchSuccessCopyWith(
          _PostFetchSuccess value, $Res Function(_PostFetchSuccess) then) =
      __$PostFetchSuccessCopyWithImpl<$Res>;
  $Res call({List<Property> properties});
}

/// @nodoc
class __$PostFetchSuccessCopyWithImpl<$Res>
    extends _$AdminStateCopyWithImpl<$Res>
    implements _$PostFetchSuccessCopyWith<$Res> {
  __$PostFetchSuccessCopyWithImpl(
      _PostFetchSuccess _value, $Res Function(_PostFetchSuccess) _then)
      : super(_value, (v) => _then(v as _PostFetchSuccess));

  @override
  _PostFetchSuccess get _value => super._value as _PostFetchSuccess;

  @override
  $Res call({
    Object? properties = freezed,
  }) {
    return _then(_PostFetchSuccess(
      properties == freezed
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<Property>,
    ));
  }
}

/// @nodoc

class _$_PostFetchSuccess implements _PostFetchSuccess {
  const _$_PostFetchSuccess(this.properties);

  @override
  final List<Property> properties;

  @override
  String toString() {
    return 'AdminState.postFetchSuccess(properties: $properties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PostFetchSuccess &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(properties);

  @JsonKey(ignore: true)
  @override
  _$PostFetchSuccessCopyWith<_PostFetchSuccess> get copyWith =>
      __$PostFetchSuccessCopyWithImpl<_PostFetchSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Property> properties) initial,
    required TResult Function() fetchingPosts,
    required TResult Function(List<Property> properties) postFetchSuccess,
    required TResult Function(String errorMessage) postFetchFailure,
    required TResult Function() rejectApproveOk,
    required TResult Function(String errorMessage) rejectApproveError,
  }) {
    return postFetchSuccess(properties);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Property> properties)? initial,
    TResult Function()? fetchingPosts,
    TResult Function(List<Property> properties)? postFetchSuccess,
    TResult Function(String errorMessage)? postFetchFailure,
    TResult Function()? rejectApproveOk,
    TResult Function(String errorMessage)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (postFetchSuccess != null) {
      return postFetchSuccess(properties);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingPosts value) fetchingPosts,
    required TResult Function(_PostFetchSuccess value) postFetchSuccess,
    required TResult Function(_PostFetchFailure value) postFetchFailure,
    required TResult Function(_RejectApproveOk value) rejectApproveOk,
    required TResult Function(_RejectApproveError value) rejectApproveError,
  }) {
    return postFetchSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingPosts value)? fetchingPosts,
    TResult Function(_PostFetchSuccess value)? postFetchSuccess,
    TResult Function(_PostFetchFailure value)? postFetchFailure,
    TResult Function(_RejectApproveOk value)? rejectApproveOk,
    TResult Function(_RejectApproveError value)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (postFetchSuccess != null) {
      return postFetchSuccess(this);
    }
    return orElse();
  }
}

abstract class _PostFetchSuccess implements AdminState {
  const factory _PostFetchSuccess(List<Property> properties) =
      _$_PostFetchSuccess;

  List<Property> get properties => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$PostFetchSuccessCopyWith<_PostFetchSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$PostFetchFailureCopyWith<$Res> {
  factory _$PostFetchFailureCopyWith(
          _PostFetchFailure value, $Res Function(_PostFetchFailure) then) =
      __$PostFetchFailureCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class __$PostFetchFailureCopyWithImpl<$Res>
    extends _$AdminStateCopyWithImpl<$Res>
    implements _$PostFetchFailureCopyWith<$Res> {
  __$PostFetchFailureCopyWithImpl(
      _PostFetchFailure _value, $Res Function(_PostFetchFailure) _then)
      : super(_value, (v) => _then(v as _PostFetchFailure));

  @override
  _PostFetchFailure get _value => super._value as _PostFetchFailure;

  @override
  $Res call({
    Object? errorMessage = freezed,
  }) {
    return _then(_PostFetchFailure(
      errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_PostFetchFailure implements _PostFetchFailure {
  const _$_PostFetchFailure(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AdminState.postFetchFailure(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PostFetchFailure &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorMessage);

  @JsonKey(ignore: true)
  @override
  _$PostFetchFailureCopyWith<_PostFetchFailure> get copyWith =>
      __$PostFetchFailureCopyWithImpl<_PostFetchFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Property> properties) initial,
    required TResult Function() fetchingPosts,
    required TResult Function(List<Property> properties) postFetchSuccess,
    required TResult Function(String errorMessage) postFetchFailure,
    required TResult Function() rejectApproveOk,
    required TResult Function(String errorMessage) rejectApproveError,
  }) {
    return postFetchFailure(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Property> properties)? initial,
    TResult Function()? fetchingPosts,
    TResult Function(List<Property> properties)? postFetchSuccess,
    TResult Function(String errorMessage)? postFetchFailure,
    TResult Function()? rejectApproveOk,
    TResult Function(String errorMessage)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (postFetchFailure != null) {
      return postFetchFailure(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingPosts value) fetchingPosts,
    required TResult Function(_PostFetchSuccess value) postFetchSuccess,
    required TResult Function(_PostFetchFailure value) postFetchFailure,
    required TResult Function(_RejectApproveOk value) rejectApproveOk,
    required TResult Function(_RejectApproveError value) rejectApproveError,
  }) {
    return postFetchFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingPosts value)? fetchingPosts,
    TResult Function(_PostFetchSuccess value)? postFetchSuccess,
    TResult Function(_PostFetchFailure value)? postFetchFailure,
    TResult Function(_RejectApproveOk value)? rejectApproveOk,
    TResult Function(_RejectApproveError value)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (postFetchFailure != null) {
      return postFetchFailure(this);
    }
    return orElse();
  }
}

abstract class _PostFetchFailure implements AdminState {
  const factory _PostFetchFailure(String errorMessage) = _$_PostFetchFailure;

  String get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$PostFetchFailureCopyWith<_PostFetchFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$RejectApproveOkCopyWith<$Res> {
  factory _$RejectApproveOkCopyWith(
          _RejectApproveOk value, $Res Function(_RejectApproveOk) then) =
      __$RejectApproveOkCopyWithImpl<$Res>;
}

/// @nodoc
class __$RejectApproveOkCopyWithImpl<$Res>
    extends _$AdminStateCopyWithImpl<$Res>
    implements _$RejectApproveOkCopyWith<$Res> {
  __$RejectApproveOkCopyWithImpl(
      _RejectApproveOk _value, $Res Function(_RejectApproveOk) _then)
      : super(_value, (v) => _then(v as _RejectApproveOk));

  @override
  _RejectApproveOk get _value => super._value as _RejectApproveOk;
}

/// @nodoc

class _$_RejectApproveOk implements _RejectApproveOk {
  const _$_RejectApproveOk();

  @override
  String toString() {
    return 'AdminState.rejectApproveOk()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _RejectApproveOk);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Property> properties) initial,
    required TResult Function() fetchingPosts,
    required TResult Function(List<Property> properties) postFetchSuccess,
    required TResult Function(String errorMessage) postFetchFailure,
    required TResult Function() rejectApproveOk,
    required TResult Function(String errorMessage) rejectApproveError,
  }) {
    return rejectApproveOk();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Property> properties)? initial,
    TResult Function()? fetchingPosts,
    TResult Function(List<Property> properties)? postFetchSuccess,
    TResult Function(String errorMessage)? postFetchFailure,
    TResult Function()? rejectApproveOk,
    TResult Function(String errorMessage)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (rejectApproveOk != null) {
      return rejectApproveOk();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingPosts value) fetchingPosts,
    required TResult Function(_PostFetchSuccess value) postFetchSuccess,
    required TResult Function(_PostFetchFailure value) postFetchFailure,
    required TResult Function(_RejectApproveOk value) rejectApproveOk,
    required TResult Function(_RejectApproveError value) rejectApproveError,
  }) {
    return rejectApproveOk(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingPosts value)? fetchingPosts,
    TResult Function(_PostFetchSuccess value)? postFetchSuccess,
    TResult Function(_PostFetchFailure value)? postFetchFailure,
    TResult Function(_RejectApproveOk value)? rejectApproveOk,
    TResult Function(_RejectApproveError value)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (rejectApproveOk != null) {
      return rejectApproveOk(this);
    }
    return orElse();
  }
}

abstract class _RejectApproveOk implements AdminState {
  const factory _RejectApproveOk() = _$_RejectApproveOk;
}

/// @nodoc
abstract class _$RejectApproveErrorCopyWith<$Res> {
  factory _$RejectApproveErrorCopyWith(
          _RejectApproveError value, $Res Function(_RejectApproveError) then) =
      __$RejectApproveErrorCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class __$RejectApproveErrorCopyWithImpl<$Res>
    extends _$AdminStateCopyWithImpl<$Res>
    implements _$RejectApproveErrorCopyWith<$Res> {
  __$RejectApproveErrorCopyWithImpl(
      _RejectApproveError _value, $Res Function(_RejectApproveError) _then)
      : super(_value, (v) => _then(v as _RejectApproveError));

  @override
  _RejectApproveError get _value => super._value as _RejectApproveError;

  @override
  $Res call({
    Object? errorMessage = freezed,
  }) {
    return _then(_RejectApproveError(
      errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RejectApproveError implements _RejectApproveError {
  const _$_RejectApproveError(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AdminState.rejectApproveError(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RejectApproveError &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorMessage);

  @JsonKey(ignore: true)
  @override
  _$RejectApproveErrorCopyWith<_RejectApproveError> get copyWith =>
      __$RejectApproveErrorCopyWithImpl<_RejectApproveError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Property> properties) initial,
    required TResult Function() fetchingPosts,
    required TResult Function(List<Property> properties) postFetchSuccess,
    required TResult Function(String errorMessage) postFetchFailure,
    required TResult Function() rejectApproveOk,
    required TResult Function(String errorMessage) rejectApproveError,
  }) {
    return rejectApproveError(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Property> properties)? initial,
    TResult Function()? fetchingPosts,
    TResult Function(List<Property> properties)? postFetchSuccess,
    TResult Function(String errorMessage)? postFetchFailure,
    TResult Function()? rejectApproveOk,
    TResult Function(String errorMessage)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (rejectApproveError != null) {
      return rejectApproveError(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingPosts value) fetchingPosts,
    required TResult Function(_PostFetchSuccess value) postFetchSuccess,
    required TResult Function(_PostFetchFailure value) postFetchFailure,
    required TResult Function(_RejectApproveOk value) rejectApproveOk,
    required TResult Function(_RejectApproveError value) rejectApproveError,
  }) {
    return rejectApproveError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingPosts value)? fetchingPosts,
    TResult Function(_PostFetchSuccess value)? postFetchSuccess,
    TResult Function(_PostFetchFailure value)? postFetchFailure,
    TResult Function(_RejectApproveOk value)? rejectApproveOk,
    TResult Function(_RejectApproveError value)? rejectApproveError,
    required TResult orElse(),
  }) {
    if (rejectApproveError != null) {
      return rejectApproveError(this);
    }
    return orElse();
  }
}

abstract class _RejectApproveError implements AdminState {
  const factory _RejectApproveError(String errorMessage) =
      _$_RejectApproveError;

  String get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$RejectApproveErrorCopyWith<_RejectApproveError> get copyWith =>
      throw _privateConstructorUsedError;
}
