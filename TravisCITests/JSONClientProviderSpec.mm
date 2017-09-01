#import "Cedar.h"
#import "JSONClientProvider.h"
#import "HTTPClient.h"
#import "JSONClient.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(JSONClientProviderSpec)

describe(@"JSONClientProvider", ^{
    __block JSONClientProvider *subject;
    __block HTTPClient *httpClient;

    beforeEach(^{

        httpClient = nice_fake_for([HTTPClient class]);
        subject = [[JSONClientProvider alloc]initWithHTTPClient:httpClient];
    });

    describe(NSStringFromSelector(@selector(provideInstance)), ^{
        __block JSONClient *jsonClient;
        beforeEach(^{
            jsonClient = [subject provideInstance];
        });

        it(@"should correctly configure the jsonClient", ^{
            jsonClient.httpClient should be_same_instance_as(httpClient);
        });
    });
});

SPEC_END
