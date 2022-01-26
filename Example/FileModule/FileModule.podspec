Pod::Spec.new do |spec|

  spec.name     = 'FileModule'
  spec.version  = '0.0.2'
  spec.license  = 'MIT'
  spec.homepage = 'https://github.com/baidu/CarbonGraph'
  spec.authors  = { 'Baidu' => 'carbon-core@baidu.com' }
  spec.summary  = 'File Module'
  spec.source = { :path => '.' }

  spec.swift_version    = '5.2'
  spec.ios.deployment_target  = '9.0'
  spec.source_files           = 'FileModule/**/*.swift'
  
  spec.dependency 'CarbonObjC'
  spec.dependency 'BasicModule'

end
