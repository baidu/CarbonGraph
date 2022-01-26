Pod::Spec.new do |spec|

  spec.name     = 'HomeModule'
  spec.version  = '0.0.2'
  spec.license  = 'MIT'
  spec.homepage = 'https://github.com/baidu/CarbonGraph'
  spec.authors  = { 'Baidu' => 'carbon-core@baidu.com' }
  spec.summary  = 'Home Module'
  spec.source   = { :path => '.' }

  spec.ios.deployment_target  = '9.0'
  spec.source_files           = 'HomeModule/**/*.{h,m}'
  spec.public_header_files    = 'HomeModule/Services/*.h'

  spec.dependency 'CarbonObjC'
  spec.dependency 'BasicModule'
  spec.dependency 'FileModule'
  
end
