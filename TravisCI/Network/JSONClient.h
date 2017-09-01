
#import <Foundation/Foundation.h>

@class HTTPClient;
@class KSPromise;

@interface JSONClient : NSObject

@property (nonatomic, readonly) HTTPClient *httpClient;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDataDictionary:(NSDictionary *)dictionary  UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithHTTPClient:(HTTPClient *)httpClient NS_DESIGNATED_INITIALIZER;

- (KSPromise *)sendRequest:(NSURLRequest *)request;

@end
