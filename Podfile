# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ContactsApp' do

  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'iOS-Utils', '~> 1.6'
  pod 'UIImageView-Letters', '~> 1.1'

  # Pods for ContactsApp

  target 'ContactsAppTests' do
    inherit! :search_paths
  end

  target 'ContactsAppUITests' do
  end

end


post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.4'
		end
	end
end
