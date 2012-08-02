/**
 * Copyright 2012 StackMob
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "SMPushClient.h"

static SMPushClient *defaultClient = nil;

@interface SMPushClient ()

@property(nonatomic, readwrite, copy) NSString *appAPIVersion;
@property(nonatomic, readwrite, copy) NSString *publicKey;
@property(nonatomic, readwrite, copy) NSString *privateKey;
@property(nonatomic, readwrite, copy) NSString *host;

@end

@implementation SMPushClient

@synthesize appAPIVersion = _SM_appAPIVersion;
@synthesize privateKey = _SM_privateKey;
@synthesize publicKey = _SM_publicKey;
@synthesize host = _SM_host;

- (id)initWithAPIVersion:(NSString *)appAPIVersion publicKey:(NSString *)publicKey privateKey:(NSString *)privateKey
{
    self = [self init];
    if (self)
    {
        self.appAPIVersion = appAPIVersion;
        self.publicKey = publicKey;
        self.privateKey = privateKey;
        self.host = @"push.stackmob.com";
        if ([SMPushClient defaultClient] == nil)
        {
            [SMPushClient setDefaultClient:self];
        }
    }
    return self;
}


+ (void)setDefaultClient:(SMPushClient *)client
{
    defaultClient = client;
}

+ (SMPushClient *)defaultClient
{
    return defaultClient;
}

@end
