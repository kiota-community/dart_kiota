/// This library implements de-/serialization for the
/// application/x-www-form-urlencoded content type.
///
/// This library is not meant to be used directly, but rather to be used as a
/// dependency in the generated code.
library microsoft_kiota_serialization_form;

import 'dart:convert';
import 'dart:typed_data';

import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:uuid/uuid.dart';

part 'src/form_parse_node.dart';
part 'src/form_parse_node_factory.dart';
part 'src/form_serialization_writer.dart';
part 'src/form_serialization_writer_factory.dart';
