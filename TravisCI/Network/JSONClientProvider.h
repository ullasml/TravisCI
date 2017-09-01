

#import <Foundation/Foundation.h>

@class JSONClient;
@class HTTPClient;

@interface JSONClientProvider : NSObject

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDataDictionary:(NSDictionary *)dictionary  UNAVAILABLE_ATTRIBUTE;

-(JSONClient *)provideInstance;

- (instancetype)initWithHTTPClient:(HTTPClient *)httpClient NS_DESIGNATED_INITIALIZER;


@end
