#import "Cedar.h"
#import "HTTPClient.h"
#import "KSDeferred.h"
#import "KSNetworkClient.h"
#import "KSPromise.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HTTPClientSpec)

describe(@"HTTPClient", ^{
    __block HTTPClient *subject;
    __block NSOperationQueue *operationQueue;
    __block KSPromise *httpClientPromise;
    __block NSURLSession *session;
    __block NSURLSessionDataTask *task;
    __block NSURLRequest *request;
    __block NSURLRequest *expectedRequest;
    


    __block void (^simulateNetworkResponse)(NSData *, NSURLResponse *, NSError *);

    beforeEach(^{
        task = nice_fake_for([NSURLSessionDataTask class]);
        session = nice_fake_for([NSURLSession class]);
        request = nice_fake_for([NSURLRequest class]);
        request stub_method(@selector(URL)).and_return([NSURL URLWithString:@"my-special-URL"]);
        operationQueue = nice_fake_for([NSOperationQueue class]);

        session stub_method(@selector(dataTaskWithRequest:completionHandler:))
        .and_do_block(^NSURLSessionDataTask *(NSURLRequest *receivedRequest, void (^completionHandler)(NSData *, NSURLResponse *, NSError *)){
            expectedRequest = receivedRequest;
            simulateNetworkResponse = [completionHandler copy];
            return task;
        });
        subject = [[HTTPClient alloc]initWithURLSession:session queue:operationQueue];
        httpClientPromise = [subject sendRequest:request];
    });
    
    it(@"should return a promise", ^{
        httpClientPromise should_not be_nil;
    });
    
    it(@"should send the request to the session", ^{
        session should have_received(@selector(dataTaskWithRequest:completionHandler:))
        .with(request, Arguments::anything);
    });
    
    it(@"should resume the data task ", ^{
        task should have_received(@selector(resume));
    });

    context(@"When the network promise is successfull", ^{

        __block NSData *data;
        __block NSURLResponse *response;
        beforeEach(^{
            data = nice_fake_for([NSData class]);
            response = nice_fake_for([NSURLResponse class]);
            simulateNetworkResponse(data, response, nil);
        });

        it(@"should resolve the promise with correct data", ^{
            httpClientPromise.fulfilled should be_truthy;
            httpClientPromise.value should equal(data);
        });
    });

    context(@"When the network promise fails", ^{
        __block NSError *error;
        beforeEach(^{
            error = nice_fake_for([NSError class]);
            simulateNetworkResponse(nil, nil, error);
        });

        it(@"should reject the promise with the correct error", ^{
            httpClientPromise.rejected should be_truthy;
            httpClientPromise.error should equal(error);
        });
    });
});

SPEC_END
