Pod::Spec.new do |s|
    s.name                  = 'AVStyleKit'
    s.module_name           = 'AVStyleKit'

    s.version               = '0.6.0'

    s.homepage              = 'https://github.com/motylevm/avstylekit'
    s.summary               = 'Framework for styling visual elements in ios apps'

    s.author                = { 'Mikhail Motylev' => 'motylevm@gmail.com' }
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.platforms             = { :ios => '8.0' }
    s.ios.deployment_target = '8.0'

    s.source_files          = 'Sources/*.swift'
    s.resources             = 'Res/*.json'
    s.source                = { :git => 'https://github.com/motylevm/avstylekit.git', :tag => s.version }
end