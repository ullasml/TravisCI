

#import <Foundation/Foundation.h>

@protocol KSNetworkClient ;
@class KSPromise;

@interface HTTPClient : NSObject


@property(nonatomic, readonly) id <KSNetworkClient> networkClient;
@property(nonatomic, readonly) NSOperationQueue *operationQueue;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDataDictionary:(NSDictionary *)dictionary  UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithOperationQueue:(NSOperationQueue *)operationQueue
                         networkClient:(id<KSNetworkClient>)networkClient;

-(KSPromise *)sendRequest:(NSURLRequest *)request;
@end
