stackmob-ios-push-sdk
================

[https://www.stackmob.com](https://www.stackmob.com)

# Getting started

## Add the StackMobPush SDK to your app

### Using CocoaPods

[CocoaPods](https://github.com/CocoaPods/CocoaPods) is a dependency management tool for iOS apps. Using it you can easily express the external libraries (like StackMob) your app relies on and install them.

Create a new iOS project in Xcode. Here we've created an app named "MobFind".

		$ cd MobFind
		$ ls -F
		MobFind/  MobFind.xcodeproj/  MobFindTests/

We need to create a Podfile to contain our project's configuration for CocoaPods. From within your project folder:

		$ touch Podfile
		$ open Podfile 

Your Podfile defines your app's dependencies on other libraries. Add StackMob to it.

		platform :ios
		pod 'StackMobPush'

Now you can use CocoaPods to install your dependencies.

		$ pod install
				
Your now have a workspace containing your app's project and a project build by CocoaPods which will build a static library containing all of the dependencies listed in your Podfile.
		
		$ ls -F 
		MobFind/  MobFind.xcodeproj/  MobFind.xcworkspace/  MobFindTests/  Podfile  		Podfile.lock  Pods/
		
Open the new workspace and we can start developing using the StackMob library

		$ open MobFind.xcworkspace

## Configure the StackMob SDK to use your StackMob account

# Development

## Testing

[Kiwi](https://github.com/allending/Kiwi) specs run just like OCUnit tests. In Xcode `⌘U` will run all the tests for the current scheme.

		describe(@"a public method or feature", ^{
			beforeEach(^{
				//set up
				[[someClass stubAndReturn:aResult] aMethod];
			});
			context(@"when some precondition exists", ^{
				beforeEach(^{
					//set the precondition
				});
				it(@"should have a specific behavior", ^{
					//verify the behavior
					[[aThing shouldNot] equal:someOtherThing];
				});
			    pending(@"should eventually have another behavior", ^{
			    	//pending specs will not execute and generate warnings
			    	[[[anObject should] receive] aMethodWith:anArgument];
			    	[anObject doStuff];
			    });
			    context(@"and another condition exists", ^{
			    	//...
			    });
			});
		});
		
### Integration Tests

Unit tests do not make network requests against StackMob. The project includes a seperate target of integration tests to verify communication with the StackMob API.

1. `cp integration-tests/StackMobCredentials.plist.example integration-tests/StackMobCredentials.plist`
2. `open integration-tests/StackMobCredentials.plist`
3. Set the public and private keys for the StackMob account you want the tests to use.
5. Run the "integration-tests" scheme.

## Using the SDK in a test app during development

1. Install the SDK in your app using CocoaPods
2. Replace <your app>/Pods/StackMobPush with a symlink to your development copy of the SDK
3. Your app's Pods project will use the current source of your development copy of the SDK on every build.


## Submitting pull requests

0. Fork the repository on github and clone your fork.
1. Create a topic branch: `git checkout -b make_sdk_better`.
2. Write some tests for your change.
3. Make the tests pass.
4. Commit your changes.
5. (Go to #2.)
6. Make sure your topic branch is up to date with any changes other developers have added to master while you were working: `git checkout master && git pull && git checkout - && git merge master` (`git rebase master` for local branches if you prefer).
7. Push your topic branch to your fork: `git push origin make_sdk_better`.
8. Create a pull request on github asking StackMob to merge your topic branch into StackMob's master branch.
