#ifndef SPICE_NEARBY_NEARBY_H
#define SPICE_NEARBY_NEARBY_H

#include <spice/util/Singleton.h>

namespace spice {
namespace nearby {

enum class ResultCode {
    //Android only
    PUBLISH_SUCCEED = 0xb001,
    //Andriod only
    PUBLISH_FAILED = 0xb002,
    //Android&iOS
    PUBLISH_EXPIRED = 0xb003,
    //Android only
    SUBSCRIBE_FAILED = 0xc001,
    //Android&iOS
    SUBSCRIBE_LOST = 0xc002,
    //Android&iOS
    SUBSCRIBE_EXPRIED = 0xc003,
    //Android only
    PLAY_SERVICES_CONNECTED = 0xd001,
    //Android only
    PLAY_SERVICES_SUSPENDED = 0xd003
};

class PublishCallback {
public:
    //Android only
	virtual void onResult(ResultCode resultCode) = 0;
};

class SubscribeCallback {
public:
	virtual void onSucceed(const char* content, int len) = 0;
	virtual void onStop(ResultCode errorCode) = 0;
};

class Nearby :public spice::util::Singleton<Nearby>{
public:

	void setPublishCallback(PublishCallback* publish_callback);
    PublishCallback* getPublishCallback();
    SubscribeCallback* getSubscribeCallback();
	void setSubscribeCallback(SubscribeCallback* subscribe_callback);
	void setPublishTTL(int message_TTL);
	void setSubscribeTTL(int message_TTL);
    void setupForiOS();
	void publish(const char* message, int len);
	void unpublish(const char* message, int len);
	void subscribe();
	void unsubscribe();


private:
	PublishCallback* m_publish_callback = nullptr;
	SubscribeCallback* m_subscribe_callback = nullptr;

};
}
}

#endif //SPICE_NEARBY_NEARBY_H