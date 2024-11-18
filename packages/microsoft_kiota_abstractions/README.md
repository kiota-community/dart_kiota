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
>   microsoft_kiota_abstractions:
>     git:
>       url: https://github.com/kiota-community/dart_kiota.git
>       ref: main
>       path: packages/microsoft_kiota_abstractions
> ```

```bash
dart pub add microsoft_kiota_abstractions
```
