# PinView

A library that customizes PIN and OTP Views.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

PinView requires minimum deployment target iOS 11.


### Installing

### Swift Package Manager

To integrate using Apple's Swift package manager, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/RamyRizkalla/PinView.git", .upToNextMajor(from: "1.0.0-beta-4"))
```

## Usage

Simply drag a UIStackView to your storyboard and change the class type to `PinView`. `PinView` provides a list of attributes that you can change to customize how it looks and changes while typing in.
