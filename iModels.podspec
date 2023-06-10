#
# Be sure to run `pod lib lint iModels.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iModels'
  s.version          = '0.1.0'
  s.summary          = 'This library provide device(iPhone) model name with human readable way'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This library facilitates developers in easily determining the device model, which is particularly valuable for gathering statistics on user device distribution. It offers various other benefits as well.
                       DESC

  s.homepage         = 'https://github.com/AnbalaganD/iModels.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anbalagan D' => 'anbu94p@gmail.com' }
  s.source           = { :git => 'https://github.com/AnbalaganD/iModels.git', :tag => s.version.to_s }
  s.swift_version    = '5.7'

  s.ios.deployment_target = '12.0'

  s.source_files = 'iModels/Classes/**/*'
end
