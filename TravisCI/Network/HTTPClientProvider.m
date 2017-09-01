

#import "HTTPClientProvider.h"
#import "KSNetworkClient.h"
#import "HTTPClient.h"

@interface HTTPClientProvider ()

@property(nonatomic) id <KSNetworkClient> networkClient;
@property(nonatomic) NSOperationQueue *operationQueue;

@end



@implementation HTTPClientProvider

- (instancetype)initWithOperationQueue:(NSOperationQueue *)operationQueue networkClient:(id<KSNetworkClient>)networkClient {
    self = [super init];
    if (self) {

        self.operationQueue = operationQueue;
        self.networkClient = networkClient;
    }
    return self;
}

- (HTTPClient *)provideInstance;
{
    return [[HTTPClient alloc]initWithOperationQueue:self.operationQueue
                                       networkClient:self.networkClient];
}

@end
