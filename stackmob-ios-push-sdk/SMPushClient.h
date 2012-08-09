/*
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

#import <Foundation/Foundation.h>

#define DEFAULT_PUSH_HOST @"push.stackmob.com"

/** SMSuccessBlock
 */
typedef void (^SMSuccessBlock)();

/** SMResultSuccessBlock
 */
typedef void (^SMResultSuccessBlock)(NSDictionary *result);

/** SMResultsSuccessBlock
 */
typedef void (^SMResultsSuccessBlock)(NSArray *results);

/** SMFailureBlock
 */
typedef void (^SMFailureBlock)(NSError *error);

/**
 An `SMPushClient` provides a high level interface to interacting with StackMob's push service. A new client must be given an API Version and OAuth credentials in order to communicate with your StackMob application.
 
 `SMPushClient` sets default values for other configuration settings which may be set as necessary by your application.
 
 `SMPushClient` exposes a defaultClient for applications which use a globally available client to share configuration settings.
 
 Include `#import "StackMobPush.h"` in your application files to gain access to `SMPushClient` and SMPushToken methods.
 
 */
@interface SMPushClient : NSObject

@property(nonatomic, readonly, copy) NSString *appAPIVersion;
@property(nonatomic, readonly, copy) NSString *publicKey;
@property(nonatomic, readonly, copy) NSString *privateKey;
@property(nonatomic, readonly, copy) NSString *host;

///--------------------
/// @name Initialize
///--------------------

/**
 Initialize with only the most basic parameters and defaults for the rest.
 
 @param appAPIVersion The API version of your StackMob application which this client instance should use.
 @param publicKey Your StackMob application's OAuth publicKey.
 @param privateKey Your StackMob application's OAuth privateKey.
 
 */
- (id)initWithAPIVersion:(NSString *)appAPIVersion publicKey:(NSString *)publicKey privateKey:(NSString *)privateKey;

/**
 Initialize specifying all parameters.
 
 @param appAPIVersion The API version of your StackMob application which this client instance should use.
 @param publicKey Your StackMob application's OAuth publicKey.
 @param privateKey Your StackMob application's OAuth privateKey.
 @param host The url of StackMob's push server
 
 */
- (id)initWithAPIVersion:(NSString *)appAPIVersion publicKey:(NSString *)publicKey privateKey:(NSString *)privateKey pushHost:(NSString *)host;


+ (void)setDefaultClient:(SMPushClient *)client;

+ (SMPushClient *)defaultClient;


///--------------------
/// @name Registering a Device Token
///--------------------

/** 
 Register a device token for push notifications. 
 
 Device tokens must be registered before they can be pushed to. Each token is associated with a username on the server, and this can be used to simplify pushing to users on multiple devices and platforms via sendMessage:toUsers:onSuccess:onFailure:. The username can correspond to a regular StackMob username, but it doesn't have to. You can also ignore usernames altogether by specifying an arbitrary value and working entirely with tokens. This call will overwrite existing tokens.
 
 @param token The device token for this device.
 @param username A name to be associated with the device token.
 @param successBlock The block to call on success.
 @param failureBlock The block to call on failure.
 
 */
- (void)registerDeviceToken:(id)token withUser:(NSString *)username onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock;

/** 
 Register a device token for push notifications. 
 
 Device tokens must be registered before they can be pushed to. Each token is associated with a username on the server, and this can be used to simplify pushing to users on multiple devices and platforms via sendMessage:toUsers:onSuccess:onFailure:. The username can correspond to a regular StackMob username, but it doesn't have to. You can also ignore usernames altogether by specifying an arbitrary value and working entirely with tokens. This call will fail if the token is already registered unless the overwrite flag is set.
 
 @param token The device token for this device.
 @param username A name to be associated with the device token.
 @param overwrite When set registering an existing token will succeed.
 @param successBlock The block to call on success.
 @param failureBlock The block to call on failure.
 
 */
- (void)registerDeviceToken:(id)token withUser:(NSString *)username overwrite:(BOOL)overwrite onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock;


///--------------------
/// @name Sending Push Notifications
///--------------------

/** 
 Broadcast a message to all registered devices for this app. 
 
 The message will be sent to all users on all platforms.
 
 @param message The message to send. See [Apple's docs](http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ApplePushService/ApplePushService.html) for details on format.
 @param successBlock The block to call on success
 @param failureBlock The block to call on failure
 
 */
- (void)broadcastMessage:(NSDictionary *)message onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock;

/**
 Send a message to a particular set of users 
 
 The users must have been previously registered by registerDeviceToken:withUser:onSuccess:onFailure:  
 
 @param message The message to send. See [Apple's docs](http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ApplePushService/ApplePushService.html) for details on format.
 @param users An array of username strings to push to.
 @param successBlock The block to call on success.
 @param failureBlock The block to call on failure.
 
 */
- (void)sendMessage:(NSDictionary *)message toUsers:(NSArray *)users onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock;

/**
 Send a message to specific tokens. 
 
 The tokens must have been registered with StackMob by registerDeviceToken:withUser:onSuccess:onFailure:  
 
 @param message The message to send. See [Apple's docs](http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ApplePushService/ApplePushService.html) for details on format.
 @param tokens An array containing either device token strings or SMPushToken objects to push to.
 @param successBlock The block to call on success.
 @param failureBlock The block to call on failure.
 
 */
- (void)sendMessage:(NSDictionary *)message toTokens:(NSArray *)tokens onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock;


///--------------------
/// @name Retrieving Tokens For Users
///--------------------

/**
 Get the tokens registered for the given users. 
 
 If successful the onSuccess block will be called with an NSDictionary mapping username strings to NSArrays of SMPushToken objects.
 
 @param users An array of username strings to query.
 @param successBlock The block to call on success.
 @param failureBlock The block to call on failure.
 
 */
- (void)getTokensForUsers:(NSArray *)users onSuccess:(SMResultSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock;


///--------------------
/// @name Deleting a Device Token
///--------------------

/**
 
 Deletes the token from StackMob's server.
 
 @param token A token represented by either a device token string or an SMPushToken object.
 @param successBlock The block to call on success.
 @param failureBlock The block to call on failure.
 */
- (void)deleteToken:(id)token onSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock;

@end
