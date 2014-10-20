Pod::Spec.new do |s|
  s.name         = "OLEContainerScrollView"
  s.version      = "0.0.1"
  s.summary      = "A UIScrollView subclass that intelligently handles multiple child scroll views and does not interfere with UIKitʼs cell reuse functionality."
  s.homepage     = "http://EXAMPLE/OLEContainerScrollView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Ole Begemann"
  s.platform     = :ios
  s.source       = { :git => "git@github.com:basecamp/OLEContainerScrollView.git", :tag => "0.0.1" }
  s.source_files  = "OLEContainerScrollView/*.{h,m}"
end
