#import "Cedar.h"
#import "JSONClient.h"
#import "HTTPClient.h"
#import "KSDeferred.h"
#import "KSPromise.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(JSONClientSpec)

describe(@"JSONClient", ^{
    __block JSONClient *subject;
    __block HTTPClient *httpClient;
    __block NSURLRequest *urlRequest;
    __block KSPromise *jsonPromise;
    __block KSDeferred *httpDeferred;

    beforeEach(^{

        httpDeferred = [[KSDeferred alloc]init];
        httpClient = nice_fake_for([HTTPClient class]);
        urlRequest = nice_fake_for([NSURLRequest class]);
        httpClient stub_method(@selector(sendRequest:)).with(urlRequest).and_return(httpDeferred.promise);
        subject = [[JSONClient alloc]initWithHTTPClient:httpClient];
        jsonPromise = [subject sendRequest:urlRequest];

    });

    describe(NSStringFromSelector(@selector(sendRequest:)), ^{
        it(@"makes a request to the correct url", ^{
            httpClient should have_received(@selector(sendRequest:)).with(urlRequest);
        });
        context(@"when the json client fetching data is successfull", ^{

            context(@"When data is Valid json Data", ^{
                __block NSDictionary *expectedJSON;
                beforeEach(^{
                    expectedJSON = @{@"foo": @[@"bar"]};
                    NSString *jsonString = @"{\"foo\": [\"bar\"]}";
                    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

                    [httpDeferred resolveWithValue:data];
                });
                it(@"should resolve the promise with correct json ", ^{
                    jsonPromise.value should equal(expectedJSON);
                    jsonPromise.fulfilled should be_truthy;
                });
            });

            context(@"When data is not a valid json data", ^{
                beforeEach(^{
                    [httpDeferred resolveWithValue:[NSData data]];
                });
                it(@"should resolve the promise with correct json ", ^{
                    jsonPromise.fulfilled should be_falsy;
                    jsonPromise.error should_not be_nil;
                    jsonPromise.error should be_instance_of([NSError class]);
                });
            });


        });

        context(@"when the json client fetching data is failed", ^{
            __block NSError *error;
            beforeEach(^{

                [httpDeferred rejectWithError:error];
            });
            it(@"should reject the promise with correct erroe ", ^{
                jsonPromise.error should be_same_instance_as(error);
                jsonPromise.rejected should be_truthy;
            });

        });
    });


});

SPEC_END
