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

@interface SMPushToken : NSObject

@property(nonatomic, copy) NSString *tokenString;
@property(nonatomic, copy) NSString *type;
@property(nonatomic) long registeredMilliseconds;


-(id)initWithString:(NSString *)tokenString;
-(id)initWithString:(NSString *)tokenString type:(NSString *)type;


@end
