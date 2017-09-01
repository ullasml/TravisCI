#import "Cedar.h"
#import "UserServiceDeserializer.h"
#import "User.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(UserServiceDeserializerSpec)

describe(@"UserServiceDeserializer", ^{
    __block UserServiceDeserializer *subject;
    __block NSArray *allUsersArray;

    beforeEach(^{

        NSString *fixturePath = [[NSBundle mainBundle] pathForResource:@"users" ofType:@"json"];
        NSData *fixtureData = [NSData dataWithContentsOfFile:fixturePath];
        NSArray *users = [NSJSONSerialization JSONObjectWithData:fixtureData options:0 error:nil];
        
        subject = [[UserServiceDeserializer alloc]init];
        allUsersArray = [subject deserialize:users];
    });

    it(@"should deserialize correctly", ^{
        allUsersArray.count should equal(2);

        User *firstUser = [[User alloc]initWithName:@"Leanne Graham"
                                              email:@"Sincere@april.biz"
                                              phone:@"1-770-736-8031 x56442"
                                            website:@"hildegard.org"];
        User *secondUser = [[User alloc]initWithName:@"Clementina DuBuque"
                                               email:@"Rey.Padberg@karina.biz"
                                               phone:@"024-648-3804"
                                             website:@"ambrose.net"];
        allUsersArray.firstObject should equal(firstUser);
        allUsersArray.lastObject should equal(secondUser);

    });


});

SPEC_END
