

#import "HTTPClient.h"
#import "KSNetworkClient.h"
#import "KSPromise.h"
#import "KSDeferred.h"

@interface HTTPClient ()
@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSOperationQueue *queue;


@end

@implementation HTTPClient


- (instancetype)initWithURLSession:(NSURLSession *)session
                             queue:(NSOperationQueue *)queue {
    self = [super init];
    if (self) {
        self.session = session;
        self.queue = queue;
    }
    return self;
}

#pragma mark - NSObject

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (KSPromise *)sendRequest:(NSURLRequest *)request {
    
    KSDeferred *deferred = [[KSDeferred alloc] init];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                         if (error) {
                                                             //[self.queue addOperationWithBlock:^{
                                                                 [deferred rejectWithError:error];
                                                             //}];
                                                         }
                                                         else{ 
                                                             //[self.queue addOperationWithBlock:^{
                                                                 [deferred resolveWithValue:data];                                                            
                                                             //}];
                                                             
                                                         }
                                                     }];
    [dataTask resume];
    return deferred.promise;
}
@end
