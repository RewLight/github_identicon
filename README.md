# Github Identicon

A simple package for generating Github flavor Identicons.  
There is also a out-of-box component for instant use.

## Features

`GithubIdenticonGenerator`: The core of this package.  
`GithhbIdenticon`: The out-of-box component.  

## Getting started

1. add `github_identicon: ^1.0.0` as a dependency in your `pubspec.yaml`;  
2. import and use it;
3. maybe enjoy it I guess?

## Usage

Both `GithubIdenticon` and `GithubIdenticonGenerator` have the same args:  

https://github.com/RewLight/github_identicon/blob/54f48c145d2c9a45eced6ea72024a399bfefdd1b/lib/github_identicon_generator.dart#L7-L17  

For example:  
```dart
GithubIdenticon(
  seed: "octocat",
  size: 256,
  showGrid: false // Do notice that `showGrid` is an optional arg and defaults to `true`.
)
```  

## License

MIT License.  
