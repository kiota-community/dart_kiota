/// This library implements a request adapter for generated
/// [Kiota](https://github.com/microsoft/kiota) clients.
library kiota_http;

import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:uuid/uuid.dart';

part 'src/http_client_request_adapter.dart';
part 'src/kiota_client_factory.dart';
