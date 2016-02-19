//
//  NearbyMessage.m
//  NearbyMessagesExample
//
//  Created by huang liangjin on 2016/02/03.
//  Copyright © 2016年 Google. All rights reserved.
//

#import "NearbyMessage.h"
#import <AVFoundation/AVAudioSession.h>
static NSString * const GoogleAPIKey = @"AIzaSyCtEg6WxB21BdRH6tSrVkhhaitJsJ_dEdw";

@implementation NearbyMessage
static NearbyMessage* mInstance = nil;

+ (NearbyMessage *) getInstance {
    @synchronized(self) {
        if (!mInstance) {
            mInstance = [NearbyMessage new];
        }
    }
    return mInstance;
}

-(void) initialize {

    [GNSMessageManager setDebugLoggingEnabled:YES];
    _mMessageManager = [[GNSMessageManager alloc] initWithAPIKey:GoogleAPIKey paramsBlock:^(GNSMessageManagerParams *params) {
        params.microphonePermissionErrorHandler = ^(BOOL hasError) {
            if([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission)])
            {
                [[AVAudioSession sharedInstance] requestRecordPermission];
            }
        };
    }];
    
}

-(void) publish:(const char *)message withLength:(int)length {
    NSData *tempMsg = [[NSData alloc] initWithBytes:message length:length];
    GNSMessage *pubMessage = [GNSMessage messageWithContent:tempMsg];
    
    NSString * temp = [[NSString alloc] initWithData:tempMsg encoding:NSUTF8StringEncoding];
    NSLog(@"publish %@", temp);


    GNSStrategy* pubStrategy = [GNSStrategy strategyWithParamsBlock:^(GNSStrategyParams *params) {
        params.discoveryMediums = kGNSDiscoveryMediumsDefault;
        params.discoveryMode = kGNSDiscoveryModeDefault; //both broadcast and scan
        params.includeBLEBeacons = NO;
    }];
    _publication = [_mMessageManager publicationWithParams:[GNSPublicationParams paramsWithMessage:pubMessage
                                                                           strategy:pubStrategy]];
}

-(void) subscribe {
    GNSStrategy* subStrategy = [GNSStrategy strategyWithParamsBlock:^(GNSStrategyParams *params) {
        params.discoveryMediums = kGNSDiscoveryMediumsDefault;
        params.discoveryMode = kGNSDiscoveryModeDefault; //both broadcast and scan
        params.includeBLEBeacons = NO;
    }];
    _subscription = [_mMessageManager subscriptionWithParams:[GNSSubscriptionParams paramsWithStrategy:subStrategy] messageFoundHandler:^(GNSMessage *message) {
        if (_mSubscribeCallback) {
            _mSubscribeCallback->onSucceed((const char*)message.content.bytes, (int)message.content.length);
        }
        NSString * temp = [[NSString alloc] initWithData:message.content encoding:NSUTF8StringEncoding];
        NSLog(@"subscribe %@", temp);
    } messageLostHandler:^(GNSMessage *message) {
        if (_mSubscribeCallback) {
            _mSubscribeCallback->onStop(spice::nearby::ResultCode::SUBSCRIBE_LOST);
        }
    }];
}

-(void) unsubscribe {
    _subscription = nil;
}
@end
