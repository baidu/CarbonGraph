Pod::Spec.new do |spec|

  spec.name         = 'CarbonCore'
  spec.version      = '1.3.3'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.summary      = 'Swift dependency injection framework for iOS'
  spec.homepage     = 'https://github.com/baidu/CarbonGraph'
  spec.authors      = { 'Baidu' => 'carbon-core@baidu.com' }
  spec.source       = { :git => 'https://github.com/baidu/CarbonGraph.git', :tag => spec.version }
  
  spec.swift_version          = '5.5'
  spec.ios.deployment_target  = '9.0'

  spec.source_files           = 'CarbonCore/CarbonCore/**/*.swift'
  
end
