Pod::Spec.new do |s|

  s.name         = "XYVolumeHandler"
  s.version      = "0.0.5"
  s.summary      = "Graceful handle the volume changes in your iOS apps like Instagram."
  s.description  = "Graceful handle the volume changes in your iOS apps like Instagram. YEAH!"
  s.homepage     = "https://github.com/X140Yu/XYVolumeHandler"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "X140Yu" => "zhaoxinyu1994@gmail.com" }

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/X140Yu/XYVolumeHandler.git", :tag => "#{s.version}" }
  s.source_files  = "Classes/*.{h,m}"
  
  s.dependency 'CWStatusBarNotification'

end
