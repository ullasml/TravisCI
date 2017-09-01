

#import "HTTPClient.h"
#import "KSNetworkClient.h"
#import "KSPromise.h"

@interface HTTPClient ()

@property(nonatomic) id <KSNetworkClient> networkClient;
@property(nonatomic) NSOperationQueue *operationQueue;
@end

@implementation HTTPClient


- (instancetype)initWithOperationQueue:(NSOperationQueue *)operationQueue networkClient:(id<KSNetworkClient>)networkClient {
    self = [super init];
    if (self) {

        self.operationQueue = operationQueue;
        self.networkClient = networkClient;
    }
    return self;
}

#pragma mark - NSObject

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (KSPromise *)sendRequest:(NSURLRequest *)request {
    KSPromise *networkPromise = [self.networkClient sendAsynchronousRequest:request queue:self.operationQueue];

    return [networkPromise then:^id(KSNetworkResponse *networkResponse) {
        return networkResponse.data;
    } error:^id(NSError *error) {
        return error;
    }];
}
@end
