#
# Be sure to run `pod lib lint Async.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Async'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Async.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/fpg1503/Async'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fpg1503' => 'fpg1503@gmail.com' }
  s.source           = { :git => 'https://github.com/fpg1503/Async.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Async/Classes/*'
  
  # s.resource_bundles = {
  #   'Async' => ['Async/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'BrightFutures'

  s.subspec 'PromiseKit' do |promiseKit|
    promiseKit.dependency 'PromiseKit'
    promiseKit.source_files = 'Async/Classes/Async+PromiseKit.swift'
  end

  s.subspec 'Promises' do |promises|
    promises.dependency 'Promises'
    promises.source_files = 'Async/Classes/Async+Promises.swift'
  end

  s.subspec 'HydraAsync' do |hydraAsync|
    hydraAsync.dependency 'HydraAsync'
    hydraAsync.source_files = 'Async/Classes/Async+HydraAsync.swift'
  end

  s.subspec 'Then' do |thenPromise|
    thenPromise.dependency 'thenPromise'
    thenPromise.source_files = 'Async/Classes/Async+Then.swift'
  end

  s.subspec 'Alamofire' do |alamofire|
    alamofire.dependency 'Alamofire'
    alamofire.source_files = 'Async/Classes/Alamofire+Async.swift'
  end
end
