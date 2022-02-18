Pod::Spec.new do |spec|

  spec.name     = 'CarbonObjC'
  spec.version  = '1.3.0'
  spec.license  = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage = 'https://github.com/baidu/CarbonGraph'
  spec.authors  = { 'Baidu' => 'carbon-core@baidu.com' }
  spec.summary  = 'CarbonCore\'s ObjC adaptation framework'
  spec.source   = { :git => 'https://github.com/baidu/CarbonGraph.git', :tag => spec.version }

  spec.swift_version          = ['5.2', '5.3', '5.4', '5.5']
  spec.ios.deployment_target  = '9.0'
  spec.source_files           = 'CarbonObjC/CarbonObjC/**/*.{h,m,swift}'
  
  spec.dependency 'CarbonCore'

end
