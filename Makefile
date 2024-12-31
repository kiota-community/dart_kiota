format:
	dart format packages
	dart format tooling

generate: generate-abstractions generate-bundle generate-http generate-serialization-form generate-serialization-json generate-serialization-multipart

generate-abstractions:
	cd packages/microsoft_kiota_abstractions && dart run build_runner build --delete-conflicting-outputs

generate-bundle:
	cd packages/microsoft_kiota_bundle && dart run build_runner build --delete-conflicting-outputs

generate-http:
	cd packages/microsoft_kiota_http && dart run build_runner build --delete-conflicting-outputs

generate-serialization-form:
	cd packages/microsoft_kiota_serialization_form && dart run build_runner build --delete-conflicting-outputs

generate-serialization-json:
	cd packages/microsoft_kiota_serialization_json && dart run build_runner build --delete-conflicting-outputs

generate-serialization-multipart:
	cd packages/microsoft_kiota_serialization_multipart && dart run build_runner build --delete-conflicting-outputs

test: test-abstractions test-bundle test-http test-serialization-text test-serialization-form test-serialization-json test-serialization-multipart

test-abstractions: pub-get-abstractions generate-abstractions
	cd packages/microsoft_kiota_abstractions && dart test

test-bundle: pub-get-bundle generate-bundle
	cd packages/microsoft_kiota_bundle && dart test

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
