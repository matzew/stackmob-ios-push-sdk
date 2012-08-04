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

#import <Kiwi/Kiwi.h>
#import "SMIntegrationTestHelpers.h"
#import "StackMobPush.h"

SPEC_BEGIN(SMUserSessionIntegrationSpec)

describe(@"SMPushClient", ^{

    __block NSString *token0 = @"0000000000000000000000000000000000000000000000000000000000000000";
    __block NSString *token1 = @"1111111111111111111111111111111111111111111111111111111111111111";
    __block NSString *token2 = @"2222222222222222222222222222222222222222222222222222222222222222";
    __block BOOL createSuccess0 = NO;
    __block BOOL createSuccess1 = NO;
    __block BOOL createSuccess2 = NO;
    __block BOOL deleteSuccess = NO;
    __block SMPushClient *defaultClient = nil;
    beforeEach(^{
        // create object to login with, assumes user object name with username/password fields
        defaultClient = [SMIntegrationTestHelpers defaultClient];
        
        createSuccess0 = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient registerDeviceToken:token0 withUser:@"bodie" onSuccess:^{
                createSuccess0 = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                createSuccess0 = NO;
                syncReturn(semaphore);
            }];
        });
        
        createSuccess1 = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient registerDeviceToken:token1 withUser:@"bodie" onSuccess:^{
                createSuccess1 = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                createSuccess1 = NO;
                syncReturn(semaphore);
            }];
        });
        
        createSuccess2 = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient registerDeviceToken:token2 withUser:@"nola" onSuccess:^{
                createSuccess2 = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                createSuccess2 = NO;
                syncReturn(semaphore);
            }];
        });
        
    });
    afterEach(^{
        deleteSuccess = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient deleteToken:token0 onSuccess:^{
                deleteSuccess = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                deleteSuccess = NO;
                syncReturn(semaphore);
            }];
        });
        
        [[theValue(deleteSuccess) should] beYes];
        
        deleteSuccess = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient deleteToken:token1 onSuccess:^{
                deleteSuccess = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                deleteSuccess = NO;
                syncReturn(semaphore);
            }];
        });
        
        [[theValue(deleteSuccess) should] beYes];
        
        deleteSuccess = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient deleteToken:token2 onSuccess:^{
                deleteSuccess = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                deleteSuccess = NO;
                syncReturn(semaphore);
            }];
        });
        
        [[theValue(deleteSuccess) should] beYes];
    });
    describe(@"register token", ^{
        it(@"should succeed given valid tokens", ^{
            [[theValue(createSuccess0) should] beYes];
            [[theValue(createSuccess1) should] beYes];
            [[theValue(createSuccess2) should] beYes];
        });
        
        it(@"should fail with a nonexitant token", ^{
            __block BOOL failed = NO;
            syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
                [defaultClient registerDeviceToken:token1 withUser:@"herc" onSuccess:^{
                    failed = NO;
                    syncReturn(semaphore);
                } onFailure:^(NSError *theError) {
                    failed = YES;
                    syncReturn(semaphore);
                }];
            });
            [[theValue(failed) should] beYes];
        });

    });
        
 });

SPEC_END