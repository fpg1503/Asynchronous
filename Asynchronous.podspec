#
# Be sure to run `pod lib lint Asynchronous.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Asynchronous'
  s.version          = '0.1.0'
  s.summary          = 'Implementation agnostic asynchronous code'
  s.default_subspecs = 'BrightFutures'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Async is a one-stop shop for your async needs, the user can use the subspecs
to automatically run the Async code using Promises, PromiseKit, Then, BrightFutures,
HydraAsync and much more!
                       DESC

  s.homepage         = 'https://github.com/fpg1503/Asynchronous'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fpg1503' => 'fpg1503@gmail.com' }
  s.source           = { :git => 'https://github.com/fpg1503/Asynchronous.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/fpg1503'

  s.ios.deployment_target = '9.0'


  s.subspec 'BrightFutures' do |brightFutures|
    brightFutures.dependency 'BrightFutures'
    brightFutures.source_files = 'Asynchronous/Classes/Async.swift'
  end

  s.subspec 'PromiseKit' do |promiseKit|
    promiseKit.dependency 'PromiseKit'
    promiseKit.source_files = 'Asynchronous/Classes/Async+PromiseKit.swift'
  end

  s.subspec 'Promises' do |promises|
    promises.dependency 'Promises'
    promises.source_files = 'Asynchronous/Classes/Async+Promises.swift'
  end

  s.subspec 'HydraAsync' do |hydraAsync|
    hydraAsync.dependency 'HydraAsync'
    hydraAsync.source_files = 'Asynchronous/Classes/Async+HydraAsync.swift'
  end

  s.subspec 'Then' do |thenPromise|
    thenPromise.dependency 'thenPromise'
    thenPromise.source_files = 'Asynchronous/Classes/Async+Then.swift'
  end

  s.subspec 'Alamofire' do |alamofire|
    alamofire.dependency 'Alamofire'
    alamofire.source_files = 'Asynchronous/Classes/Alamofire+Async.swift'
  end
end
