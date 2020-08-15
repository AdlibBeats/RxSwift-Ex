platform :ios, '13.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
inhibit_all_warnings!

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if target.name == 'VoxImplantWebRTC' || target.name == 'VoxImplantSDK' || target.name == 'VoxImplant'
              config.build_settings['ENABLE_BITCODE'] = 'NO'
            end
        end
    end
end

def shared_pods
  pod 'Swinject', '2.6.0'
  pod 'SwinjectStoryboard'
  
  pod 'Moya/RxSwift'
  pod 'AlamofireImage'
  
  pod 'RxKeyboard'
  pod 'RxBinding'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxFeedback'
  pod 'RxGesture'
  pod 'RxRealm', '2.0.0'
  pod 'RxReachability'
  pod 'RxLocalizer'
  pod 'RxUIAlert'
  
  pod 'CombineBinding'
  
  pod 'Then'
  pod 'Align', '1.2.1'
  pod 'SVProgressHUD'
  
  pod 'VoxImplantSDK'
end

target 'RxSwift-Ex' do
  shared_pods
end
