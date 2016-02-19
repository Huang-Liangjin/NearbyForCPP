//
//  Nearby_iOS.m
//  NearbyMessagesExample
//
//  Created by huang liangjin on 2016/02/03.
//  Copyright © 2016年 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Nearby.h"
#import "NearbyMessage.h"

namespace spice{
namespace nearby {
    void Nearby::setPublishCallback(PublishCallback* publish_callback) {
        m_publish_callback = publish_callback;
        [[NearbyMessage getInstance] setMPublishCallback:m_publish_callback];
    }
    
    void Nearby::setSubscribeCallback(SubscribeCallback* subscribe_callback) {
        m_subscribe_callback = subscribe_callback;
        [[NearbyMessage getInstance] setMSubscribeCallback:m_subscribe_callback];
    }
    
    PublishCallback* Nearby::getPublishCallback() {
        return m_publish_callback;
    }
    
    SubscribeCallback* Nearby::getSubscribeCallback() {
        return m_subscribe_callback;
    }
    
    void Nearby::setPublishTTL(int message_TTL) {
        [[NearbyMessage getInstance] setPublishTTL:message_TTL];
    }
    void Nearby::setSubscribeTTL(int message_TTL) {
        [[NearbyMessage getInstance] setSubscribeTTL:message_TTL];
    }
    void Nearby::setupForiOS() {
        [[NearbyMessage getInstance] initialize];
    }
    
    void Nearby::publish(const char* message, int len) {
        [[NearbyMessage getInstance] publish:message withLength:len];
    }
    void Nearby::unpublish(const char* message, int len) {
        [[NearbyMessage getInstance] unpublish:message withLength:len];
    }
    void Nearby::subscribe() {
        [[NearbyMessage getInstance] subscribe];
    }
    void Nearby::unsubscribe() {
        [[NearbyMessage getInstance] unsubscribe];
    }

}
}


