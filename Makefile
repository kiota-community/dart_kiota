pub-get: pub-get-abstractions pub-get-http pub-get-serialization-text pub-get-serialization-form

pub-get-abstractions:
	cd packages/kiota_abstractions && dart pub get

pub-get-http:
	cd packages/kiota_http && dart pub get

pub-get-serialization-text:
	cd packages/kiota_serialization_text && dart pub get

pub-get-serialization-form:
	cd packages/kiota_serialization_form && dart pub get

format:
	dart format packages

generate: generate-abstractions generate-http generate-serialization-form

generate-abstractions:
	cd packages/kiota_abstractions && dart run build_runner build --delete-conflicting-outputs

generate-http:
	cd packages/kiota_http && dart run build_runner build --delete-conflicting-outputs

generate-serialization-form:
	cd packages/kiota_serialization_form && dart run build_runner build --delete-conflicting-outputs

test: test-abstractions test-http test-serialization-text test-serialization-form

test-abstractions: pub-get-abstractions generate-abstractions
	cd packages/kiota_abstractions && dart test

test-http: pub-get-http generate-http
	cd packages/kiota_http && dart test

test-serialization-text: pub-get-serialization-text
	cd packages/kiota_serialization_text && dart test

test-serialization-form: pub-get-serialization-form generate-serialization-form
	cd packages/kiota_serialization_form && dart test
