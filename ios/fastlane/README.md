fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios beta

```sh
[bundle exec] fastlane ios beta
```

TestFlight에 업로드

### ios upload_only

```sh
[bundle exec] fastlane ios upload_only
```

빌드된 IPA만 TestFlight에 업로드

### ios release

```sh
[bundle exec] fastlane ios release
```

App Store에 제출

### ios metadata

```sh
[bundle exec] fastlane ios metadata
```

메타데이터 업로드

### ios screenshots

```sh
[bundle exec] fastlane ios screenshots
```

스크린샷만 업로드

### ios texts

```sh
[bundle exec] fastlane ios texts
```

스토어 글만 올리기 — fastlane texts version:1.5.1 (기본은 출시 노트만 · all:true 면 설명 · 키워드 · 홍보 문구 · 부제도)

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
