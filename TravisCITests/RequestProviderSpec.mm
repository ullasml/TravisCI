#import "Cedar.h"
#import "RequestProvider.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RequestProviderSpec)

describe(@"RequestProvider", ^{
    __block RequestProvider *subject;
    __block NSURLRequest *urlRequest;
    beforeEach(^{

        subject = [[RequestProvider alloc]init];
        urlRequest = [subject requestForAllUsersService];
    });

    it(@"generates a request to get all artists", ^{
        urlRequest.URL should equal([NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"]);
    });
});

SPEC_END
