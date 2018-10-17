Pod::Spec.new do |s|
    s.name                  = 'SKStyleKit'
    s.module_name           = 'SKStyleKit'

    s.version               = '1.1.2'

    s.homepage              = 'https://github.com/motylevm/skstylekit'
    s.summary               = 'Framework for styling visual elements in ios apps'

    s.author                = { 'Mikhail Motylev' => 'motylevm@gmail.com' }
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.platforms             = { :ios => '8.0' }
    s.ios.deployment_target = '8.0'

    s.source_files          = 'Sources/*.swift'
    s.resources             = 'Res/*.json'
    s.source                = { :git => 'https://github.com/motylevm/skstylekit.git', :tag => s.version }
end