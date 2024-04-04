/// This library implements a request adapter for generated
/// [Kiota](https://github.com/microsoft/kiota) clients.
library kiota_http;

import 'dart:math';
import 'dart:mirrors';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:uuid/uuid.dart';

part 'src/http_client_request_adapter.dart';
part 'src/kiota_client_factory.dart';
part 'src/middleware/redirect_handler.dart';
part 'src/middleware/redirect_handler_option.dart';
part 'src/middleware/retry_handler_option.dart';
part 'src/middleware/retry_handler.dart';
