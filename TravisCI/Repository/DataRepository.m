

#import "DataRepository.h"
#import "KSPromise.h"
#import "JSONClient.h"
#import "RequestProvider.h"
#import "KSDeferred.h"
#import "UserServiceDeserializer.h"


@interface DataRepository ()

@property (nonatomic) JSONClient *jsonClient;
@property (nonatomic) RequestProvider *requestProvider;
@property (nonatomic) UserServiceDeserializer *userServiceDeserializer;


@end


@implementation DataRepository

- (instancetype)initWithUserServiceDeserializer:(UserServiceDeserializer *)userServiceDeserializer
                                requestProvider:(RequestProvider *)requestProvider
                                     jsonClient:(JSONClient *)jsonClient {
    self = [super init];
    if (self) {
        self.jsonClient = jsonClient;
        self.requestProvider = requestProvider;
        self.userServiceDeserializer = userServiceDeserializer;
    }
    return self;
}

#pragma mark - NSObject

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(KSPromise *)getData
{
    KSDeferred *allUsersServiceDeferred = [[KSDeferred alloc]init];
    NSURLRequest *urlrequest = [self.requestProvider requestForAllUsersService];
    KSPromise *jsonPromise = [self.jsonClient sendRequest:urlrequest];
    [jsonPromise then:^id(NSArray *jsonValueDict) {
        NSArray *allUsersArray = [self.userServiceDeserializer deserialize:jsonValueDict];
        [allUsersServiceDeferred resolveWithValue:allUsersArray];
        return nil;
    } error:^id(NSError *error) {
        [allUsersServiceDeferred rejectWithError:error];
        return nil;
    }];
    return allUsersServiceDeferred.promise;
}
@end
