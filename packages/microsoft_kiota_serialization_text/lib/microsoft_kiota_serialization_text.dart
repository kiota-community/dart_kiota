/// This library implements deserialization for text/plain responses.
///
/// This library is not meant to be used directly, but rather to be used as a
/// dependency in the generated code.
library microsoft_kiota_serialization_text;

import 'dart:convert';
import 'dart:typed_data';

import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:uuid/uuid_value.dart';

part 'src/text_parse_node.dart';
part 'src/text_parse_node_factory.dart';
part 'src/text_serialization_writer.dart';
part 'src/text_serialization_writer_factory.dart';
