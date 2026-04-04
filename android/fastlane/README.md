fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android metadata

```sh
[bundle exec] fastlane android metadata
```

메타데이터만 업로드 (설명, 스크린샷)

### android internal

```sh
[bundle exec] fastlane android internal
```

내부 테스트 트랙에 업로드

### android internal_with_metadata

```sh
[bundle exec] fastlane android internal_with_metadata
```

내부 테스트 + 메타데이터 업로드

### android release

```sh
[bundle exec] fastlane android release
```

프로덕션에 업로드

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
