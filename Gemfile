source 'https://rubygems.org'

# Shared by android/fastlane and ios/fastlane (bundler finds this file from either directory).
gem 'fastlane', '~> 2.240'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
