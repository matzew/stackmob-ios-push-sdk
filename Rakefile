task :default => []

desc "Run unit tests"
task :test do
	system %Q(osascript -e 'tell app "iPhone Simulator" to quit')
	raise "Specs failed." unless system %Q(xcodebuild -workspace stackmob-ios-push-sdk.xcworkspace -scheme "stackmob-ios-push-sdkTests" -sdk iphonesimulator -configuration Debug build)
end

namespace "test" do
	desc "Run integration tests"
	task :integration do
		system %Q(osascript -e 'tell app "iPhone Simulator" to quit')
		raise "Specs failed." unless system %Q(xcodebuild -workspace stackmob-ios-push-sdk.xcworkspace -scheme "integration-tests" -sdk iphonesimulator -configuration Debug build)
	end
end

task :clean do
  exec "xcodebuild -alltargets clean"
  exec "rm -rf ~/Library/Application\ Support/iPhone\ Simulator/*"
  exec "rm -rf ~/Library/Developer/Xcode/DerivedData/stackmob-ios-sdk*"
  exec "rm -rf ~/Library/Caches/appCode10/DerivedData/stackmob-ios-sdk*"
end