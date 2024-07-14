/// Every project generated via [Kiota](https://github.com/microsoft/kiota)
/// needs an abstractions library to provide the necessary interfaces and
/// abstractions to interact with the generated code.
///
/// This library is not meant to be used directly, but rather to be used as a
/// dependency in the generated code.
library kiota_abstractions;

import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:std_uritemplate/std_uritemplate.dart';
import 'package:uuid/uuid.dart';

part 'src/api_client_builder.dart';
part 'src/api_exception.dart';
part 'src/authentication/access_token_provider.dart';
part 'src/authentication/allowed_hosts_validator.dart';
part 'src/authentication/anonymous_authentication_provider.dart';
part 'src/authentication/api_key_authentication_provider.dart';
part 'src/authentication/api_key_location.dart';
part 'src/authentication/authentication_provider.dart';
part 'src/authentication/base_bearer_token_authentication_provider.dart';
part 'src/base_request_builder.dart';
part 'src/case_insensitive_map.dart';
part 'src/date_only.dart';
part 'src/error_mappings.dart';
part 'src/extensions/base_request_builder_extensions.dart';
part 'src/extensions/date_only_extensions.dart';
part 'src/extensions/duration_extensions.dart';
part 'src/extensions/map_extensions.dart';
part 'src/extensions/request_information_extensions.dart';
part 'src/extensions/time_only_extensions.dart';
part 'src/http_headers.dart';
part 'src/http_method.dart';
part 'src/multipart_body.dart';
part 'src/native_response_handler.dart';
part 'src/native_response_wrapper.dart';
part 'src/path_parameters.dart';
part 'src/query_parameters.dart';
part 'src/request_adapter.dart';
part 'src/request_configuration.dart';
part 'src/request_information.dart';
part 'src/request_option.dart';
part 'src/response_handler.dart';
part 'src/response_handler_option.dart';
part 'src/serialization/additional_data_holder.dart';
part 'src/serialization/enum_factory.dart';
part 'src/serialization/parsable.dart';
part 'src/serialization/parsable_factory.dart';
part 'src/serialization/parsable_hook.dart';
part 'src/serialization/parse_node.dart';
part 'src/serialization/parse_node_factory.dart';
part 'src/serialization/parse_node_factory_registry.dart';
part 'src/serialization/parse_node_proxy_factory.dart';
part 'src/serialization/serialization_writer.dart';
part 'src/serialization/serialization_writer_factory.dart';
part 'src/serialization/serialization_writer_factory_registry.dart';
part 'src/serialization/serialization_writer_proxy_factory.dart';
part 'src/store/backed_model.dart';
part 'src/store/backing_store.dart';
part 'src/store/backing_store_factory.dart';
part 'src/store/backing_store_factory_singleton.dart';
part 'src/store/backing_store_parse_node_factory.dart';
part 'src/store/backing_store_serialization_writer_proxy_factory.dart';
part 'src/store/backing_store_subscription_callback.dart';
part 'src/store/in_memory_backing_store.dart';
part 'src/store/in_memory_backing_store_factory.dart';
part 'src/time_only.dart';
