# Challo-iOS

## Getting started

1. Clone this repository
2. This project uses [xcodegen](https://github.com/yonaskolb/XcodeGen) to build the `.xcodeproj` file from the files on disk and a `project.yml` config file. 
	1. Ensure you have xcodegen installed by following the [installation guide](https://github.com/yonaskolb/XcodeGen)
	2. For machines with homebrew installed, the simplest way is to run `brew install xcodegen`	  	 
3. Ensure that `cocoapods` is > 1.10.1 by running 
```
pod --version
```
4. Build the `.xcodeproj` with: `xcodegen generate` 
5. Install dependencies with:
```
pod install
```
