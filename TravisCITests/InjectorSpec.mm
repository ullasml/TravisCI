#import "Cedar.h"
#import "BSInjector.h"
#import "InjectorProvider.h"
#import "KSURLSessionClient.h"
#import "RequestProvider.h"
#import "HTTPClient.h"
#import "JSONClient.h"
#import "UserServiceDeserializer.h"
#import "DataRepository.h"
#import "ViewController.h"
#import "DetailsViewController.h"
#import "User.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(InjectorSpec)

describe(@"Injector", ^{
    __block id<BSInjector> subject;

    beforeEach(^{
        subject = [InjectorProvider injector];
    });

    it(@"should create a KSURLSessionClient", ^{

        id<KSNetworkClient> networkClient = [subject getInstance:[KSNetworkClient class]];
        networkClient should be_instance_of([KSNetworkClient class]);
    });

    it(@"should create a RequestProvider", ^{

        RequestProvider *requestProvider = [subject getInstance:[RequestProvider class]];
        requestProvider should be_instance_of([RequestProvider class]);
    });

    it(@"should create a HTTPClient", ^{

        HTTPClient *httpClient = [subject getInstance:[HTTPClient class]];
        httpClient should be_instance_of([HTTPClient class]);
        httpClient.session should be_instance_of([NSURLSession class]).or_any_subclass();
    });

    it(@"should create a JSONClient", ^{

        JSONClient *jsonClient = [subject getInstance:[JSONClient class]];
        jsonClient should be_instance_of([JSONClient class]);
        jsonClient.httpClient should be_instance_of([HTTPClient class]);


    });
    it(@"should create a UserServiceDeserializer", ^{

        UserServiceDeserializer *userServiceDeserializer = [subject getInstance:[UserServiceDeserializer class]];
        userServiceDeserializer should be_instance_of([UserServiceDeserializer class]);

    });

    it(@"should create a DataRepository", ^{

        DataRepository *dataRepository = [subject getInstance:[DataRepository class]];
        dataRepository should be_instance_of([DataRepository class]);
        dataRepository.jsonClient should be_instance_of([JSONClient class]);;
        dataRepository.requestProvider should be_instance_of([RequestProvider class]);;
        dataRepository.userServiceDeserializer should be_instance_of([UserServiceDeserializer class]);

    });

    it(@"should create a ViewController", ^{

        ViewController *viewController = [subject getInstance:[ViewController class]];
         viewController should be_instance_of([ViewController class]);
        viewController.dataRepository should be_instance_of([DataRepository class]);

    });

});

SPEC_END
