#
#  Be sure to run `pod spec lint AimstarInAppLogSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#
Pod::Spec.new do |s|
  s.name         = 'AimstarInAppLogSDK'
  s.version      = '1.0.0'
  s.license      = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.homepage     = 'https://github.com/supsysjp/aimstar-in-app-log-ios'
  s.authors      = 'Supreme System Co., Ltd.'
  s.summary      = 'AimstarInAppLogSDK'
  s.source = { :http => "https://github.com/supsysjp/aimstar-in-app-log-ios/releases/download/#{s.version.to_s}/AimstarInAppLogSDK.zip" }
  s.ios.deployment_target = '16.0'
end