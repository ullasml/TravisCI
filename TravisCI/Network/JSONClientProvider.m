

#import "JSONClientProvider.h"
#import "HTTPClient.h"
#import "JSONClient.h"


@interface JSONClientProvider ()

@property (nonatomic) HTTPClient *httpClient;
@end
@implementation JSONClientProvider

- (instancetype)initWithHTTPClient:(HTTPClient *)httpClient
{
    self = [super init];
    if (self)
    {
        self.httpClient = httpClient;
    }
    return self;
}

-(JSONClient *)provideInstance
{
    return [[JSONClient alloc]initWithHTTPClient:self.httpClient];
}
@end
