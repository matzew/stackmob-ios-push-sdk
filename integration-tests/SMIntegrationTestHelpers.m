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

#import "SMIntegrationTestHelpers.h"


void syncWithSemaphore(void (^block)(dispatch_semaphore_t semaphore)) {
    dispatch_semaphore_t s = dispatch_semaphore_create(0);
    block(s);
    while(dispatch_semaphore_wait(s, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10.0]];
    }
    dispatch_release(s);
}

void syncReturn(dispatch_semaphore_t semaphore) {
    dispatch_semaphore_signal(semaphore);
}

@implementation SMIntegrationTestHelpers

+ (SMPushClient *)defaultClient
{
    NSURL *credentialsURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"StackMobCredentials" withExtension:@"plist"];
    NSDictionary *credentials = [NSDictionary dictionaryWithContentsOfURL:credentialsURL];
    NSString *publicKey = [credentials objectForKey:@"PublicKey"];
    NSString *privateKey = [credentials objectForKey:@"PrivateKey"];
    return [[SMPushClient alloc] initWithAPIVersion:SM_TEST_API_VERSION publicKey:publicKey privateKey:privateKey];
}

@end
