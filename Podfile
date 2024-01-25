# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
use_frameworks!

target 'SwiftProject_SportsApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  pod 'Kingfisher', '~> 7.0'
  pod 'lottie-ios'
  pod 'Alamofire'

  # Pods for SwiftProject_SportsApp

  target 'SwiftProject_SportsAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftProject_SportsAppUITests' do
    # Pods for testing
  end

end
