Pod::Spec.new do |s|
  s.name     = 'DIYMenu'
  s.version  = '0.1.0'
  s.license  = 'Apache 2.0'
  s.summary  = 'It's a modular modal menu.'
  s.homepage = 'https://github.com/dongle/diymenu'
  s.authors  = {'Jon Beilin' => 'jon@diy.org'}
  s.source   = { :git => 'https://github.com/dongle/diymenu.git', :tag => 'v0.1.0' }
  s.platform = :ios, '5.0'
  s.source_files = 'DIYMenu/*.{h,m,png}'
  s.framework = 'UIKit', 'Foundation', 'CoreGraphics', 'QuartzCore'
end