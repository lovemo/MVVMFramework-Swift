Pod::Spec.new do |s|
    s.name                  = 'SwiftMVVMKit'
    s.version      = '0.0.6'
    s.summary               = 'SwiftMVVMKit is a MVVM frameWork easy to develop iOS'
    s.homepage              = 'https://github.com/lovemo/MVVMFramework-Swift'
    s.platform     = :ios, '8.0'
    s.license               = 'MIT'
    s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
    s.source                = { :git => 'https://github.com/lovemo/MVVMFramework-Swift.git',:tag => s.version.to_s }
    s.source_files     = 'SwiftMVVMKit/**/*'
    s.requires_arc          = true
    s.frameworks             = 'Foundation', 'UIKit'

    s.dependency 'MJRefresh'
    s.dependency 'UITableView+FDTemplateLayoutCell'


end
