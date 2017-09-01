


#import <Foundation/Foundation.h>

@class HTTPClient;
@protocol KSNetworkClient;

@interface HTTPClientProvider : NSObject

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDataDictionary:(NSDictionary *)dictionary  UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithOperationQueue:(NSOperationQueue *)operationQueue
                         networkClient:(id<KSNetworkClient>)networkClient;

- (HTTPClient *)provideInstance;

@end
