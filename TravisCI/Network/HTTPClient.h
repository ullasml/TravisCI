

#import <Foundation/Foundation.h>

@protocol KSNetworkClient ;
@class KSPromise;

@interface HTTPClient : NSObject

@property (nonatomic,readonly) NSURLSession *session;
@property (nonatomic,readonly) NSOperationQueue *queue;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDataDictionary:(NSDictionary *)dictionary  UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithURLSession:(NSURLSession *)session
                             queue:(NSOperationQueue *)queue NS_DESIGNATED_INITIALIZER;

-(KSPromise *)sendRequest:(NSURLRequest *)request;
@end
