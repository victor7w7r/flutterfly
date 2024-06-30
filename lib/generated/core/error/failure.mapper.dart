// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../../../core/error/failure.dart';

class FailureMapper extends ClassMapperBase<Failure> {
  FailureMapper._();

  static FailureMapper? _instance;
  static FailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FailureMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Failure';

  static String _$message(Failure v) => v.message;
  static const Field<Failure, String> _f$message = Field('message', _$message);

  @override
  final MappableFields<Failure> fields = const {
    #message: _f$message,
  };

  static Failure _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('Failure');
  }

  @override
  final Function instantiate = _instantiate;
}

mixin FailureMappable {}
