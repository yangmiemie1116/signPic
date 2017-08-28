Pod::Spec.new do |s|
  s.name         = "sign"
  s.version      = "0.0.2"
  s.summary      = "创建签名图片"
  s.description  = <<-DESC
                   创建签名图片
                   DESC
  s.homepage     = "https://github.com/yangmiemie1116/signPic"
  s.license      = "MIT"
  s.author             = { "杨志强" => "yangzhiqiang1116@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/yangmiemie1116/signPic.git", :tag => "#{s.version}" }
  s.source_files  = "Sign/*.{h,m}"
  s.requires_arc = true
end
