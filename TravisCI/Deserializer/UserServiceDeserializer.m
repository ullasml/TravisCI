

#import "UserServiceDeserializer.h"
#import "User.h"

@implementation UserServiceDeserializer

-(NSArray *)deserialize:(NSArray *)userInfoArray
{
    NSMutableArray *allUsersArray = [NSMutableArray array];
    for (NSDictionary *dictionary in userInfoArray)
    {
        NSString *email = dictionary[@"email"];
        NSString *name = dictionary[@"name"];
        NSString *phone = dictionary[@"phone"];
        NSString *website = dictionary[@"website"];

        User *user = [[User alloc]initWithName:name email:email phone:phone website:website];
        [allUsersArray addObject:user];

    }
    return [allUsersArray copy];
}
@end
