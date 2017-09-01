

#import <Foundation/Foundation.h>

@class JSONClient;
@class RequestProvider;
@class KSPromise;
@class UserServiceDeserializer;

@interface DataRepository : NSObject

@property (nonatomic, readonly) JSONClient *jsonClient;
@property (nonatomic, readonly) RequestProvider *requestProvider;
@property (nonatomic, readonly) UserServiceDeserializer *userServiceDeserializer;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDataDictionary:(NSDictionary *)dictionary  UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithUserServiceDeserializer:(UserServiceDeserializer *)userServiceDeserializer
                                requestProvider:(RequestProvider *)requestProvider
                                     jsonClient:(JSONClient *)jsonClient;

-(KSPromise *)getData;

@end
