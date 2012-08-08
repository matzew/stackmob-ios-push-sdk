//
//  SMPushToken.m
//  stackmob-ios-push-sdk
//
//  Created by Douglas Rapp on 8/2/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "SMPushToken.h"

@implementation SMPushToken

@synthesize tokenString = _SM_tokenString;
@synthesize type = _SM_type;
@synthesize registrationTime = _SM_registrationTime;

-(id)initWithString:(NSString *)tokenString
{
    return [self initWithString:tokenString type:TOKEN_TYPE_IOS];
}

-(id)initWithString:(NSString *)tokenString type:(NSString *)type
{
    self = [self init];
    if (self)
    {
        self.tokenString = tokenString;
        self.type = type;
    }
    return self;
}


@end
