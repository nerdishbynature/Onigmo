# Onigmo

[![Build Status](https://travis-ci.org/nerdishbynature/Onigmo.svg?branch=master)](https://travis-ci.org/nerdishbynature/Onigmo)
[![codecov.io](https://codecov.io/github/nerdishbynature/Onigmo/coverage.svg?branch=master)](https://codecov.io/github/nerdishbynature/Onigmo?branch=master)

An Objective-C wrapper around [Onigmo](https://github.com/k-takata/Onigmo).

## Installation

Carthage is currently the only supported installation method:

```
github "nerdishbynature/Onigmo"
```

## Usage

### Search in String

We tried to mimic `NSRegularExpression` as close as possible, currently this library has only a initialiser and `matchesInString:error:` method implemented.

```swift
let onigmoRegex = try OnigmoRegularExpression(pattern: "a(.*)b|[e-f]+", options: .Default)
let matches = try onigmoRegex.matchesInString("zzzzaffffffffb")
let firstRange = matches["0"].rangeValue // a NSRange for the first match
```

## License

See [LICENSE](LICENSE) file for more details
