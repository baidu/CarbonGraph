Pod::Spec.new do |spec|

  spec.name     = 'BasicModule'
  spec.version  = '0.0.2'
  spec.license  = 'MIT'
  spec.homepage = 'https://github.com/baidu/CarbonGraph'
  spec.authors  = { 'Baidu' => 'carbon-core@baidu.com' }
  spec.summary  = 'Basic Module'
  spec.source = { :path => '.' }

  spec.ios.deployment_target  = '9.0'
  spec.source_files           = 'BasicModule/**/*.{h,m,swift}'
  spec.public_header_files    = 'BasicModule/Services/*.h', 'BasicModule/BasicModule.h'

  spec.dependency 'CarbonObjC'
  
end
