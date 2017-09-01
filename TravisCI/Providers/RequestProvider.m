

#import "RequestProvider.h"

@implementation RequestProvider

-(NSURLRequest *)requestForAllUsersService
{
    NSURL *url =[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"];
    return [NSURLRequest requestWithURL:url];
}
@end
