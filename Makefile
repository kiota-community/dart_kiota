pub-get: pub-get-abstractions pub-get-http pub-get-serialization-text pub-get-serialization-form pub-get-serialization-json pub-get-serialization-multipart

pub-get-abstractions:
	cd packages/microsoft_kiota_abstractions && dart pub get

pub-get-http:
	cd packages/microsoft_kiota_http && dart pub get

pub-get-serialization-text:
	cd packages/microsoft_kiota_serialization_text && dart pub get

pub-get-serialization-form:
	cd packages/microsoft_kiota_serialization_form && dart pub get

pub-get-serialization-json:
	cd packages/microsoft_kiota_serialization_json && dart pub get

pub-get-serialization-multipart:
	cd packages/microsoft_kiota_serialization_multipart && dart pub get

format:
	dart format packages

generate: generate-abstractions generate-http generate-serialization-form generate-serialization-json generate-serialization-multipart

generate-abstractions:
	cd packages/microsoft_kiota_abstractions && dart run build_runner build --delete-conflicting-outputs

generate-http:
	cd packages/microsoft_kiota_http && dart run build_runner build --delete-conflicting-outputs

generate-serialization-form:
	cd packages/microsoft_kiota_serialization_form && dart run build_runner build --delete-conflicting-outputs

generate-serialization-json:
	cd packages/microsoft_kiota_serialization_json && dart run build_runner build --delete-conflicting-outputs

generate-serialization-multipart:
	cd packages/microsoft_kiota_serialization_multipart && dart run build_runner build --delete-conflicting-outputs

test: test-abstractions test-http test-serialization-text test-serialization-form test-serialization-json test-serialization-multipart

test-abstractions: pub-get-abstractions generate-abstractions
	cd packages/microsoft_kiota_abstractions && dart test

test-http: pub-get-http generate-http
	cd packages/microsoft_kiota_http && dart test

test-serialization-text: pub-get-serialization-text
	cd packages/microsoft_kiota_serialization_text && dart test

test-serialization-form: pub-get-serialization-form generate-serialization-form
	cd packages/microsoft_kiota_serialization_form && dart test

test-serialization-json: pub-get-serialization-json generate-serialization-json
	cd packages/microsoft_kiota_serialization_json && dart test

test-serialization-multipart: pub-get-serialization-multipart generate-serialization-multipart
	cd packages/microsoft_kiota_serialization_multipart && dart test