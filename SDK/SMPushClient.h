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

#import <Foundation/Foundation.h>

/**
 * A SMPushClient provides a high level interface to interacting with StackMob. A new client must be given an APIVersion and OAuth credentials in order to communicate with your StackMob application.
 *
 * SMPushClient sets default values for other configuration settings which may be set as necessary by your application.
 *
 * SMPushClient exposes a defaultClient for applications which use a globally available client to share configuration settings.
 */
@interface SMPushClient : NSObject

@property(nonatomic, readonly, copy) NSString *appAPIVersion;
@property(nonatomic, readonly, copy) NSString *publicKey;
@property(nonatomic, readonly, copy) NSString *privateKey;
@property(nonatomic, readonly, copy) NSString *host;

/**
 * @param APIVersion The API version of your StackMob application which this client instance should use.
 * @param publicKey Your StackMob application's OAuth publicKey.
 * @param privateKey Your StackMob application's OAuth privateKey.
 */
- (id)initWithAPIVersion:(NSString *)appAPIVersion publicKey:(NSString *)publicKey privateKey:(NSString *)privateKey;


+ (void)setDefaultClient:(SMPushClient *)client;

+ (SMPushClient *)defaultClient;

@end
