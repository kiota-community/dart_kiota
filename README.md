The Kiota abstractions library for Dart defines the basic constructs Kiota projects need once
a client has been generated from an OpenAPI definition.

A [Kiota](https://github.com/microsoft/kiota) generated project will need a reference to the
abstraction package to build and run.

## Usage

Install the package in the generated project:

> For now, you can add the git repository as a dependency in your `pubspec.yaml` file:
>
> ```yaml
> dependencies:
>   kiota_abstractions:
>     git:
>       url: https://github.com/ricardoboss/dart_kiota_abstractions.git
>       ref: main
> ```

```bash
dart pub add kiota_abstractions
```

## Development

### TODO

From the comment at: https://github.com/microsoft/kiota/issues/2199#issuecomment-1772865549

- [x] Request information class
- [x] Serialization writer interface
- [x] Parse node interface
- [x] Request adapter interface

Things other abstractions have, but this one doesn't:

- [ ] Backing stores
- [ ] Authentication
- [ ] JSON serialization/deserialization
- [ ] Form data serialization/deserialization

These could be added in the future or by other packages.
