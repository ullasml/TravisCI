#import "Cedar.h"
#import "DataRepository.h"
#import "JSONClient.h"
#import "RequestProvider.h"
#import "KSDeferred.h"
#import "User.h"
#import "UserServiceDeserializer.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(DataRepositorySpec)

describe(@"DataRepository", ^{
    __block DataRepository *subject;
    __block JSONClient *jsonClient;
    __block RequestProvider *requestProvider;
    __block UserServiceDeserializer *userServiceDeserializer;

    beforeEach(^{
        userServiceDeserializer = nice_fake_for([UserServiceDeserializer class]);
        jsonClient = nice_fake_for([JSONClient class]);
        requestProvider = nice_fake_for([RequestProvider class]);
        subject = [[DataRepository alloc] initWithUserServiceDeserializer:userServiceDeserializer
                                                          requestProvider:requestProvider
                                                               jsonClient:jsonClient];
    });

    describe(@"Getting all users from service", ^{
        __block KSPromise *promise;
        __block NSURLRequest *request;
        __block KSDeferred *jsonDeferred;
        beforeEach(^{
            jsonDeferred = [[KSDeferred alloc]init];
            request = nice_fake_for([NSURLRequest class]);
            requestProvider stub_method(@selector(requestForAllUsersService)).and_return(request);


            jsonClient stub_method(@selector(sendRequest:)).with(request).and_return(jsonDeferred.promise);
            promise = [subject getData];

        });

        it(@"makes a request", ^{
            jsonClient should have_received(@selector(sendRequest:)).with(request);
        });

        it(@"resolves the promise with an array of Users when the request succeeds", ^{

            User *userA = nice_fake_for([User class]);
            User *userB = nice_fake_for([User class]);
            NSArray *expectedUsersArray = @[userA,userB];
            userServiceDeserializer stub_method(@selector(deserialize:)).and_return(expectedUsersArray);
            [jsonDeferred resolveWithValue:expectedUsersArray];

            promise.value should equal(expectedUsersArray);
        });

        it(@"should reject the promise when request fails", ^{
            NSError *error;
            [jsonDeferred rejectWithError:error];
            promise.error should be_same_instance_as(error);
        });
    });
});

SPEC_END
