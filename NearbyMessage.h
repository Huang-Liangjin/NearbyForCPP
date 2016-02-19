//
//  NearbyMessage.h
//  NearbyMessagesExample
//
//  Created by huang liangjin on 2016/02/03.
//  Copyright © 2016年 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Nearby.h"
#import <GNSMessages.h>

@interface NearbyMessage : NSObject
+ (NearbyMessage *) getInstance;
@property int retryTimes;
@property int publishTTL;
@property int subscribeTTL;
@property (nonatomic, strong)id<GNSPublication> publication;
@property (nonatomic, strong)id<GNSSubscription> subscription;
@property spice::nearby::PublishCallback* mPublishCallback;
@property spice::nearby::SubscribeCallback* mSubscribeCallback;
@property (strong)GNSMessageManager* mMessageManager;
//@property GNSPermission* mPermission;


-(void) initialize;
-(void) publish: (const char*) message withLength: (int) length;
-(void) subscribe;
-(void) unsubscribe;

@end
