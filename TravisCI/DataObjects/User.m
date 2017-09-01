

#import "User.h"

@interface User ()

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *website;

@end
@implementation User

-(instancetype)initWithName:(NSString *)name
                      email:(NSString *)email
                      phone:(NSString *)phone
                    website:(NSString *)website
{
    self = [super init];
    if (self) {
        self.name = name;
        self.email = email;
        self.phone = phone;
        self.website = website;
    }
    return self;
}

-(BOOL)isEqual:(User *)anotherObject
{
    if(![anotherObject isKindOfClass:[self class]]) {
        return NO;
    }
    BOOL nameEqual = (!self.name && !anotherObject.name) || [self.name isEqualToString:anotherObject.name];
    BOOL emailEqual = (!self.email && !anotherObject.email) || [self.email isEqualToString:anotherObject.email];
    BOOL phoneEqual = (!self.phone && !anotherObject.phone) || [self.phone isEqualToString:anotherObject.phone];
    BOOL websiteEqual = (!self.website && !anotherObject.website) || [self.website isEqualToString:anotherObject.website];

    return nameEqual && emailEqual && phoneEqual && websiteEqual;

}
@end
