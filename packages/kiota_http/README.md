The `kiota_http` package implements a HTTP client for generated Kiota clients using the
[`http`](https://pub.dev/packages/http) package.

## Usage

Install the package in the generated project:

> For now, you can add the git repository as a dependency in your `pubspec.yaml` file:
>
> ```yaml
> dependencies:
>   kiota_http:
>     git:
>       url: https://github.com/kiota-community/dart_kiota.git
>       ref: main
>       path: packages/kiota_http
> ```

```bash
dart pub add kiota_http
```

## Development

To build the package, you first need to run `build_runner`.
It generates the necessary files for the package to work and for running the tests:

```bash
dart run build_runner build -d
```
