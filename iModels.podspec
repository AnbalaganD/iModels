#
# Be sure to run `pod lib lint iModels.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iModels'
  s.version          = '0.1.3'
  s.summary          = 'This library provide device(iPhone) model name with human readable way'
  s.description      = <<-DESC
  This library facilitates developers in easily determining the device model, which is particularly valuable for gathering statistics on user device distribution. It offers various other benefits as well.
                       DESC

  s.homepage         = 'https://github.com/AnbalaganD/iModels.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anbalagan D' => 'anbu94p@gmail.com' }
  s.source           = { :git => 'https://github.com/AnbalaganD/iModels.git', :tag => s.version.to_s }
  s.swift_version    = '5.9'

  s.ios.deployment_target = '15.0'

  s.source_files = 'Sources/iModels/Classes/**/*'
end
