Pod::Spec.new do |s|
    s.name                  = 'StyleKit'
    s.module_name           = 'StyleKit'

    s.version               = '0.6.0'

    s.homepage              = 'https://github.com/motylevm/stylekit'
    s.summary               = 'Framework for styling visual elements in ios apps'

    s.author                = { 'Mikhail Motylev' => 'revenantdr@mail.ru' }
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.platforms             = { :ios => '8.0' }
    s.ios.deployment_target = '8.0'

    s.source_files          = { 'Sources/*.swift', 'Res/*.json' }
    s.source                = { :git => 'https://github.com/motylevm/stylekit.git', :tag => s.version }
end