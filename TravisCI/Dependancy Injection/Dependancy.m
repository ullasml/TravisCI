

#import "Dependancy.h"
#import "BSBinder.h"
#import "BSInjector.h"
#import "KSURLSessionClient.h"
#import "RequestProvider.h"
#import "HTTPClient.h"
#import "ViewController.h"
#import "DataRepository.h"
#import "UserServiceDeserializer.h"
#import "JSONClient.h"
#import "DetailsViewController.h"


@implementation Dependancy

- (void)configure:(id <BSBinder>)binder
{
    [binder bind:@protocol(KSNetworkClient) toClass:[KSNetworkClient class]];

    [binder bind:[NSOperationQueue class] toInstance:[NSOperationQueue mainQueue]];

    [binder bind:[HTTPClient class] toBlock:^id(NSArray *args, id<BSInjector> injector) {
        return [[HTTPClient alloc] initWithOperationQueue:[injector getInstance:[NSOperationQueue class]]
                                            networkClient:[injector getInstance:[KSNetworkClient class]]];
    }];

    [binder bind:[JSONClient class] toBlock:^id(NSArray *args, id<BSInjector> injector) {
        return [[JSONClient alloc] initWithHTTPClient:[injector getInstance:[HTTPClient class]]];
    }];

    [binder bind:[DataRepository class] toBlock:^id(NSArray *args, id<BSInjector> injector) {
        return [[DataRepository alloc] initWithUserServiceDeserializer:[injector getInstance:[UserServiceDeserializer class]]
                                                       requestProvider:[injector getInstance:[RequestProvider class]]
                                                            jsonClient:[injector getInstance:[JSONClient class]]];
    }];

    [binder bind:[ViewController class] toBlock:^id(NSArray *args, id<BSInjector> injector) {
        return [[ViewController alloc] initWithDataRepository:[injector getInstance:[DataRepository class]]];
    }];


}
@end
