Pod::Spec.new do |s|
#name必须与文件名一致
s.name              = "SCNavTabBar"

#更新代码必须修改版本号
s.version           = "1.0.0"
s.summary           = "a SCNavTabBar used on iOS."
s.description       = <<-DESC
It is a SCNavTabBar used on iOS, which implement by Objective-C.
DESC
s.homepage          = "https://github.com/ChenZhenChun/SCNavTabBar"
s.license           = 'MIT'
s.author            = { "ChenZhenChun" => "346891964@qq.com" }

#submodules 是否支持子模块
s.source            = { :git => "https://github.com/ChenZhenChun/SCNavTabBar.git", :tag => s.version, :submodules => true}
s.platform          = :ios, '7.0'
s.requires_arc = true

#source_files路径是相对podspec文件的路径

s.subspec 'SCNavTabBar' do |ss|
ss.source_files = 'SCNavTabBar/SCNavTabBar/*.{h,m}'
ss.public_header_files = 'SCNavTabBar/SCNavTabBar/*.h'
ss.resource = 'SCNavTabBar/SCNavTabBar/SCNavTabBar.bundle'
end

s.subspec 'ViewControllers' do |ss|
ss.source_files = 'SCNavTabBar/ViewControllers/*.{h,m}'
ss.public_header_files = 'SCNavTabBar/ViewControllers/*.h'
ss.dependency 'SCNavTabBar/SCNavTabBar'
ss.dependency 'SCNavTabBar/Views'
end

#Views
s.subspec 'Views' do |ss|
ss.source_files = 'SCNavTabBar/Views/*.{h,m}'
ss.public_header_files = 'SCNavTabBar/Views/*.h'
ss.dependency 'SCNavTabBar/SCNavTabBar'
end

s.frameworks = 'Foundation', 'UIKit'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'

end
