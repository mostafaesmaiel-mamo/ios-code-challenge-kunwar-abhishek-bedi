# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ContactsApp' do
	
def common_pods
	pod 'SwiftyJSON', '~> 5.0'
end

  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
	common_pods
  pod 'iOS-Utils', '~> 1.6'
	pod 'Alamofire', '~> 5.4'
  pod 'UIImageView-Letters', '~> 1.1'

  # Pods for ContactsApp

  target 'ContactsAppTests' do
    inherit! :search_paths
    # Pods for testing
		common_pods
  end

  target 'ContactsAppUITests' do
    # Pods for testing
  end

end


post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.4'
		end
	end
end
