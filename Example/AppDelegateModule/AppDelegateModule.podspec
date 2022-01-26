Pod::Spec.new do |spec|

  spec.name     = 'AppDelegateModule'
  spec.version  = '0.0.2'
  spec.license  = 'MIT'
  spec.homepage = 'https://github.com/baidu/CarbonGraph'
  spec.authors  = { 'Baidu' => 'carbon-core@baidu.com' }
  spec.summary  = 'AppDelegate Module'
  spec.source   = { :path => '.' }

  spec.ios.deployment_target  = '9.0'
  spec.source_files           = 'AppDelegateModule/**/*.swift'

  spec.dependency 'HomeModule'
  spec.dependency 'MeModule'
  
end
