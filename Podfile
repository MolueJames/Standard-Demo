workspace 'Standard-iOS.xcworkspace'
platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

project 'Standard-iOS/Standard-iOS.xcodeproj'

def standard_system_common_framework
    pod 'MJRefresh', '~> 3.1.15.7'
    pod 'ObjectMapper', '~> 3.5.1'
    pod 'Bolts-Swift', '~> 1.4.0'
    pod 'Kingfisher', '~> 4.10.0'
    pod 'Gallery', '~> 2.2.0'
    pod 'SnapKit', '~> 4.0.1'
end

target 'Standard-iOS' do
    project 'Standard-iOS/Standard-iOS.xcodeproj'
        pod 'SQLiteMigrationManager.swift', '~> 0.7.0'
        pod 'NVActivityIndicatorView', '~> 4.4.0'
        pod 'IQKeyboardManagerSwift', '6.4.2'
        pod 'SQLite.swift', '~> 0.12.0'
        pod 'CryptoSwift', '~> 0.15.0'
        pod 'JGProgressHUD', '~> 1.4'
        pod 'Alamofire', '~> 4.7'
        pod 'LeakEye', '~> 1.2.0'
        pod 'Eureka', '~> 5.2.1'
        pod 'Bugly', '~> 2.5.0'
        standard_system_common_framework
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING'] = 'YES'
        config.build_settings['CLANG_WARN_NON_LITERAL_NULL_CONVERSION'] = 'YES'
        config.build_settings['CLANG_WARN_OBJC_LITERAL_CONVERSION'] = 'YES'
        config.build_settings['CLANG_WARN_COMMA'] = 'YES'
        config.build_settings['CLANG_WARN_RANGE_LOOP_ANALYSIS'] = 'YES'
        config.build_settings['CLANG_WARN_STRICT_PROTOTYPES'] = 'YES'
        config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = 'YES'
        config.build_settings['GCC_NO_COMMON_BLOCKS'] = 'YES'
        config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
    end
end
