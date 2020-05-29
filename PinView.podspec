#
#  Be sure to run `pod spec lint PinView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "PinView"
  spec.version      = "0.0.2"
  spec.summary      = "A library that customizes PIN and OTP Views."
  spec.description  = <<-DESC
                    PinView is a library that uses UIStackView along with UITextFields to create a PIN view that is used for entering PIN Code. It's highly customizable allowing different views.
                        DESC
  spec.homepage     = "https://github.com/RamyRizkalla/PinView.git"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = "Ramy Rizkalla"
  spec.platform     = :ios, "11.0"
  spec.swift_versions = "5.0"
  spec.source       = { :git => "https://github.com/RamyRizkalla/PinView.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources", "Sources/PinView/**/*.{h,m,swift}"
  #spec.public_header_files = "PinView/**/*.h"
end
