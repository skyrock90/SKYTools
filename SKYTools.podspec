Pod::Spec.new do |s|
  s.name         = "SKYTools"
  s.version      = "1.0.3"
  s.summary      = "A common tools with me"
  s.homepage     = "https://github.com/skyrock90/SKYTools"
  s.license      = "MIT"
  s.author       = { "SKY" => "skyrock90@126.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/skyrock90/SKYTools.git", :tag => s.version}
  s.source_files = 'SKYTools/**/*.{h,m}'
  s.requires_arc = true
  s.framework  = "UIKit"
  s.resource   = "SKYTools/SKYTools.bundle"
  #s.dependency "JSONKit", "~> 1.4"
end
