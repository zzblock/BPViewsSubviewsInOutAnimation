#
# Be sure to run `pod lib lint BPViewsSubviewsInOutAnimation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BPViewsSubviewsInOutAnimation'
  s.version          = '1.0.0'
  s.summary          = 'BPViewsSubviewsInOutAnimation lets any view animate all its subviews with inout transition.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
BPViewsSubviewsInOutAnimation lets any view animate all its subviews with inout transition. Its very handy to control the order and delays of animation. Simply just set a variable named 'BPDelay' in inspector window under any view.
                       DESC

  s.homepage         = 'https://github.com/zoebhsheikh/BPViewsSubviewsInOutAnimation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Zoeb' => 'zoeb.sheikh74@gmail.com' }
  s.source           = { :git => 'https://github.com/zoebhsheikh/BPViewsSubviewsInOutAnimation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

#s.name = {"name"=>["Zoeb"]}

  s.ios.deployment_target = '8.0'

  s.source_files = 'BPViewsSubviewsInOutAnimation/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BPViewsSubviewsInOutAnimation' => ['BPViewsSubviewsInOutAnimation/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
