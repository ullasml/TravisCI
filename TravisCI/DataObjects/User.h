

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,copy,readonly) NSString *name;
@property (nonatomic,copy,readonly) NSString *email;
@property (nonatomic,copy,readonly) NSString *phone;
@property (nonatomic,copy,readonly) NSString *website;

-(instancetype)initWithName:(NSString *)name
                      email:(NSString *)email
                      phone:(NSString *)phone
                    website:(NSString *)website NS_DESIGNATED_INITIALIZER;
@end
