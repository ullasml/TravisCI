

#import "JSONClient.h"
#import "HTTPClient.h"
#import "KSPromise.h"
#import "KSDeferred.h"

@interface JSONClient ()

@property (nonatomic) HTTPClient *httpClient;

@end

@implementation JSONClient

- (instancetype)initWithHTTPClient:(HTTPClient *)httpClient
{
    self = [super init];
    if (self)
    {
        self.httpClient = httpClient;
    }
    return self;
}

#pragma mark - NSObject

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (KSPromise *)sendRequest:(NSURLRequest *)request
{
    KSDeferred *jsonDeferred = [[KSDeferred alloc]init];
    KSPromise *httpPromise = [self.httpClient sendRequest:request];

    [httpPromise then:^id(NSData *data) {

        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            [jsonDeferred rejectWithError:error];
        } else {
            [jsonDeferred resolveWithValue:jsonObject];
        }
        return nil;
    }
    error:^id(NSError *error){
        [jsonDeferred rejectWithError:error];
        return nil;
    }];
    return jsonDeferred.promise;
}

@end
