Pod::Spec.new do |s|
  s.name             = "Morgan"
  s.summary          = "A set of handy animations for your app."
  s.version          = "0.9"
  s.homepage         = "https://github.com/RamonGilabert/Morgan"
  s.license          = 'MIT'
  s.author           = { "Ramon Gilabert" => "ramon.gilabert.llop@gmail.com" }
  s.source           = {
    :git => "https://github.com/RamonGilabert/Morgan.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/RamonGilabert'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.ios.source_files = 'Sources/*'
  s.dependency 'Walker'

end
