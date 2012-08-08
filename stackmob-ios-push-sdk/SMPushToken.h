//
//  SMPushToken.h
//  stackmob-ios-push-sdk
//
//  Created by Douglas Rapp on 8/2/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TOKEN_TYPE_IOS @"ios"
#define TOKEN_TYPE_ANDROID_C2DM @"android"
#define TOKEN_TYPE_ANDROID_GCM @"androidgcm"

/**
 Represents the info needed to register a device for push with StackMob
 
 This corresponds to what's sored about each token on server: token string paired with a platform and some supplemental information. 
 
 @note In most cases you'll want to just use the device token string you get from apple directly rather than using one of these.
 
 */
@interface SMPushToken : NSObject

@property(nonatomic, copy) NSString *tokenString;
@property(nonatomic, copy) NSString *type;
@property(nonatomic) long registeredMilliseconds;


/**
 Initialize with a device token string. Assumes the type is ios
 
 @param tokenString The device token string.
 */
-(id)initWithString:(NSString *)tokenString;

/**
 Initialize with a device token string and a type.
 
 @param tokenString The device token string.
 @param type The platform the token is for. Should be one of ios, android, or androidgcm
 */
-(id)initWithString:(NSString *)tokenString type:(NSString *)type;


@end
