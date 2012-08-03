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
#import "STLOAuthClient.h"

static SMPushClient *defaultClient = nil;

@interface SMPushClient ()

@property(nonatomic, readwrite, copy) NSString *appAPIVersion;
@property(nonatomic, readwrite, copy) NSString *publicKey;
@property(nonatomic, readwrite, copy) NSString *privateKey;
@property(nonatomic, readwrite, copy) NSString *host;
@property(nonatomic, retain) STLOAuthClient *oauthClient;

@end

@implementation SMPushClient

@synthesize appAPIVersion = _SM_appAPIVersion;
@synthesize privateKey = _SM_privateKey;
@synthesize publicKey = _SM_publicKey;
@synthesize host = _SM_host;
@synthesize oauthClient = _SM_oauthClient;

- (id)initWithAPIVersion:(NSString *)appAPIVersion publicKey:(NSString *)publicKey privateKey:(NSString *)privateKey
{
    return [self initWithAPIVersion:appAPIVersion publicKey:publicKey privateKey:privateKey pushHost:DEFAULT_PUSH_HOST];
}
- (id)initWithAPIVersion:(NSString *)appAPIVersion publicKey:(NSString *)publicKey privateKey:(NSString *)privateKey pushHost:(NSString *)pushHost;
{
    self = [self init];
    if (self)
    {
        self.appAPIVersion = appAPIVersion;
        self.publicKey = publicKey;
        self.privateKey = privateKey;
        self.host = pushHost;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", pushHost]];
        self.oauthClient = [[STLOAuthClient alloc] initWithBaseURL:url consumerKey:publicKey secret:privateKey];
        NSString *acceptHeader = [NSString stringWithFormat:@"application/vnd.stackmob+json; version=%@", appAPIVersion];
        [self.oauthClient setDefaultHeader:@"Accept" value:acceptHeader];
        [self.oauthClient setParameterEncoding:AFJSONParameterEncoding];
        if ([SMPushClient defaultClient] == nil)
        {
            [SMPushClient setDefaultClient:self];
        }
    }
    return self;
}

- (void)registerDeviceToken:token withUser:(NSString *)username onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock
{
    [self registerDeviceToken:token withUser:username overwrite:NO onSuccess:successBlock onFailure:failureBlock];
}

- (void)registerDeviceToken:token withUser:(NSString *)username overwrite:(BOOL)overwrite onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock
{
    NSDictionary *tokenDict = [NSDictionary dictionaryWithObjectsAndKeys:token, @"token",
                               @"ios", @"type",
                               nil];
    
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:username, @"userId",
                          tokenDict, @"token",
                          overwrite, @"overwrite",
                          nil];
    
}

- (void)broadcastMessage:(NSDictionary *)message onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock
{
    NSDictionary *args = [NSDictionary dictionaryWithObject:message forKey:@"kvPairs"];
}

- (void)sendMessage:(NSDictionary *)message toUsers:(NSArray *)users onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:message, @"kvPairs", users, @"userIds", nil]; 
}

- (void)sendMessage:(NSDictionary *)message toTokens:(NSArray *)tokens onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock
{
    NSDictionary *payload = [NSDictionary dictionaryWithObject:message forKey:@"kvPairs"];
    NSMutableArray * tokensArray = [NSMutableArray array];
    [tokens enumerateObjectsUsingBlock:^(id token, NSUInteger idx, BOOL *stop) {
        NSDictionary * tokenDict = [NSDictionary dictionaryWithObjectsAndKeys:token, @"token", @"ios", @"type", nil];
        [tokensArray addObject:tokenDict];
    }];
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:tokensArray, @"tokens", payload, @"payload", nil];
    
}

- (void)getTokensForUsers:(NSArray *)users onSuccess:(SMResultSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock
{
    NSDictionary *args = [NSDictionary dictionaryWithObject:users forKey:@"userIds"];
}

- (void)getUsersForTokens:(NSArray *)tokens onSuccess:(SMResultSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock
{
    NSDictionary *args = [NSDictionary dictionaryWithObject:tokens forKey:@"tokens"]; 
}

- (void)deleteToken:(id)token onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:token, @"token", @"ios", @"type", nil];
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
