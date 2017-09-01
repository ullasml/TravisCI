#import "Cedar.h"
#import "HTTPClientProvider.h"
#import "KSNetworkClient.h"
#import "HTTPClient.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HTTPClientProviderSpec)

describe(@"HTTPClientProvider", ^{
    __block HTTPClientProvider *subject;
    __block NSOperationQueue *operationQueue;
    __block id <KSNetworkClient> networkClient;
    __block HTTPClient *httpClient;



    describe(@"Providing the instance of HTTP Client", ^{
        beforeEach(^{
            operationQueue = nice_fake_for([NSOperationQueue class]);
            networkClient = nice_fake_for(@protocol(KSNetworkClient));
            httpClient = nice_fake_for([HTTPClient class]);
            subject = [[HTTPClientProvider alloc]initWithOperationQueue:operationQueue
                                                          networkClient:networkClient];
            
        });

        describe(NSStringFromSelector(@selector(provideInstance)), ^{
            it(@"should return an instance with its dependencies correctly configured", ^{
               HTTPClient *httpClient = [subject provideInstance];
                httpClient.operationQueue should be_same_instance_as(operationQueue);
                httpClient.networkClient should be_same_instance_as(networkClient);
            });
        });
    });

});

SPEC_END
