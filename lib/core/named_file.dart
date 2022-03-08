import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'named_file.freezed.dart';

@freezed
class NamedFile with _$NamedFile {
  const factory NamedFile({
    required Uint8List data,
    required String name,
  }) = _NamedFile;
}
