#import "Cedar.h"
#import "HTTPClient.h"
#import "KSDeferred.h"
#import "KSNetworkClient.h"
#import "KSPromise.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HTTPClientSpec)

/*describe(@"HTTPClient", ^{
    __block HTTPClient *subject;
    __block NSOperationQueue *operationQueue;
    __block id <KSNetworkClient> networkClient;
    __block KSDeferred *networkDeferred;
    __block NSURLRequest *urlRequest;
    __block KSPromise *httpClientPromise;


    beforeEach(^{
        operationQueue = nice_fake_for([NSOperationQueue class]);
        networkClient = nice_fake_for(@protocol(KSNetworkClient));
        networkDeferred = [[KSDeferred alloc]init];
        urlRequest = nice_fake_for([NSURLRequest class]);

        networkClient stub_method(@selector(sendAsynchronousRequest:queue:)).and_return(networkDeferred.promise);
        subject = [[HTTPClient alloc]initWithOperationQueue:operationQueue
                                              networkClient:networkClient];

        httpClientPromise = [subject sendRequest:urlRequest];
    });

    context(@"When the network promise is successfull", ^{

        __block NSData *data;
        beforeEach(^{

            data = fake_for([NSData class]);
            KSNetworkResponse *networkResponse = fake_for([KSNetworkResponse class]);
            networkResponse stub_method(@selector(data)).and_return(data);
            [networkDeferred resolveWithValue:networkResponse];

        });

        it(@"should resolve the promise with correct data", ^{
            httpClientPromise.value should be_same_instance_as(data);
        });
    });

    context(@"When the network promise fails", ^{
        __block NSError *error;
        beforeEach(^{
            error = nice_fake_for([NSError class]);
            [networkDeferred rejectWithError:error];
        });

        it(@"should reject the promise with the correct error", ^{
            httpClientPromise.error should be_same_instance_as(error);
        });
    });
});*/

SPEC_END
