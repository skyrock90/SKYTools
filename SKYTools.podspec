Pod::Spec.new do |s|
  s.name         = "SKYTools"#开源项目名 要与开源代码的文件夹同名
  s.version      = "1.0.1"#开源项目版本
  s.summary      = "A common tools with me"#简单的描述
  s.homepage     = "https://github.com/skyrock90/SKYTools"#可以写上项目的主页
  s.license      = "MIT"#开原协议
  s.author       = { "SKY" => "skyrock90@126.com" }#作者
  s.platform     = :ios, "7.0"# 项目支持的最低版本
  s.source       = { :git => "https://github.com/skyrock90/SKYTools.git", :tag => s.version}#源代码的文件路径
  s.source_files = 'SKYTools/**/*.{h,m}'# 开源的文件路径（这个坑好大，后面讲）
  s.requires_arc = true
  s.framework  = "UIKit"# 用到的框架
  s.resource   = 'SKYTools/SKYTools.bundle'
  #s.dependency "JSONKit", "~> 1.4"# 依赖的第三方库
end
