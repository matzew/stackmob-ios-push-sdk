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
    __block SMPushClient *defaultClient = nil;
    beforeEach(^{
        // create object to login with, assumes user object name with username/password fields
        defaultClient = [SMIntegrationTestHelpers defaultClient];
        
        __block BOOL createSuccess = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient registerDeviceToken:token0 withUser:@"bodie" onSuccess:^{
                createSuccess = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                createSuccess = NO;
                syncReturn(semaphore);
            }];
        });
        [[theValue(createSuccess) should] beYes];
        
        createSuccess = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient registerDeviceToken:token1 withUser:@"bodie" onSuccess:^{
                createSuccess = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                createSuccess = NO;
                syncReturn(semaphore);
            }];
        });
        [[theValue(createSuccess) should] beYes];
        
        createSuccess = NO;
        syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
            [defaultClient registerDeviceToken:token2 withUser:@"nola" onSuccess:^{
                createSuccess = YES;
                syncReturn(semaphore);
            } onFailure:^(NSError *theError) {
                createSuccess = NO;
                syncReturn(semaphore);
            }];
        });
        [[theValue(createSuccess) should] beYes];
        
    });
    afterEach(^{
        __block BOOL deleteSuccess = NO;
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
        it(@"should failw with a duplicate token", ^{
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
        it(@"should fail with an invalid token", ^{
            __block BOOL failed = NO;
            syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
                [defaultClient registerDeviceToken:@"tooshort" withUser:@"herc" onSuccess:^{
                    failed = NO;
                    syncReturn(semaphore);
                } onFailure:^(NSError *theError) {
                    failed = YES;
                    syncReturn(semaphore);
                }];
            });
            [[theValue(failed) should] beYes];
        });
        it(@"should succeed with a duplicate token and the overwrite flag", ^{
            __block BOOL succeeded = NO;
            syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
                [defaultClient registerDeviceToken:token1 withUser:@"herc" overwrite:YES onSuccess:^{
                    succeeded = YES;
                    syncReturn(semaphore);
                } onFailure:^(NSError *theError) {
                    succeeded = NO;
                    syncReturn(semaphore);
                }];
            });
            [[theValue(succeeded) should] beYes];
        });
        it(@"should succeed with an SMPushToken and the overwrite flag", ^{
            __block BOOL succeeded = NO;
            syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
                SMPushToken *token = [[SMPushToken alloc] initWithString:token1];
                [defaultClient registerDeviceToken:token withUser:@"herc" overwrite:YES onSuccess:^{
                    succeeded = YES;
                    syncReturn(semaphore);
                } onFailure:^(NSError *theError) {
                    succeeded = NO;
                    syncReturn(semaphore);
                }];
            });
            [[theValue(succeeded) should] beYes];
        });
        it(@"should succeed with an SMPushToken and the overwrite flag", ^{
            __block BOOL succeeded = NO;
            __block SMPushToken *token = [[SMPushToken alloc] initWithString:@"helloworld" type:TOKEN_TYPE_ANDROID_GCM];
            syncWithSemaphore(^(dispatch_semaphore_t semaphore) {

                [defaultClient registerDeviceToken:token withUser:@"herc" overwrite:YES onSuccess:^{
                    succeeded = YES;
                    syncReturn(semaphore);
                } onFailure:^(NSError *theError) {
                    succeeded = NO;
                    syncReturn(semaphore);
                }];
            });
            [[theValue(succeeded) should] beYes];
            __block BOOL deleteSuccess = NO;
            syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
                [defaultClient deleteToken:token onSuccess:^{
                    deleteSuccess = YES;
                    syncReturn(semaphore);
                } onFailure:^(NSError *theError) {
                    deleteSuccess = NO;
                    syncReturn(semaphore);
                }];
            });
            
            [[theValue(deleteSuccess) should] beYes];
        });
    });
    describe(@"delete token", ^{
        it(@"should fail with a nonexistent token", ^{
            __block BOOL failed;
            syncWithSemaphore(^(dispatch_semaphore_t semaphore) {
                [defaultClient registerDeviceToken:@"notatoken" withUser:@"herc" onSuccess:^{
                    failed = NO;
                    syncReturn(semaphore);
                } onFailure:^(NSError *theError) {
                    failed = YES;
                    syncReturn(semaphore);
                }];
            });
            [[theValue(failed) should] beYes];
        });
        //pending(@"should succeed with an SMPushToken");
        //pending(@"should succeed with an android token");
    });

        
 });

SPEC_END