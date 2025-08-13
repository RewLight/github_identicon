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

https://github.com/RewLight/github_identicon/blob/977e98b2ed1d0a9c1c308ecf1cb02830f142c40f/lib/github_identicon_generator.dart#L8-L19  

For example:  
```dart
GithubIdenticon(
  seed: "octocat",
  size: 256
)
```  

## License

MIT License.  
