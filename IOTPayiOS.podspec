
Pod::Spec.new do |spec|


  spec.name         = "IOTPayiOS"
  spec.version      = "6.1.0"
  spec.summary      = "Online Credit Card Payment Framework for iOS."

  spec.description  = <<-DESC
  IOT Pay - Online Credit Card Payment Framework for iOS/Android/php
  Please visite https://github.com/IOTPaySDK for all SDKs,
  https://iotpay.ca for register
                   DESC

  spec.homepage     = "https://github.com/IOTPaySDK/IOTPay-iOS"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.swift_version	  = "5.0"


  spec.author             = { "DanY-Yin" => "dan@iotpay.ca" }

  spec.platform     = :ios

  spec.ios.deployment_target = "10.0"


  #spec.source       = { :git => "https://github.com/IOTPaySDK/iOSFramewrokInstallerCocoaPod.git", :tag => "#{spec.version}" }

  spec.source       = { :git => "https://github.com/IOTPaySDK/IOTPay-iOS.git", :tag => "#{spec.version}" }


  spec.source_files  = "IOTPayiOS/*.swift", "IOTPayiOS/**/*.{swift,h,m}", "IOTPayiOS/**/**/*.{swift,h,m}"

  spec.ios.resource_bundle   = { 'IOTPayiOS' => 'IOTPayiOS/Resources/*.{lproj,json,png,xcassets}' }

end
