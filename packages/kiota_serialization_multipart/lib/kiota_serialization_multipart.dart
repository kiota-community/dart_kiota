/// This library implements deserialization for text/plain responses.
///
/// This library is not meant to be used directly, but rather to be used as a
/// dependency in the generated code.
library kiota_serialization_text;

import 'dart:convert';
import 'dart:typed_data';

import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:uuid/uuid_value.dart';

part 'src/multipart_serialization_writer.dart';
part 'src/multipart_serialization_writer_factory.dart';
