#import "InjectorProvider.h"
#import "BSInjector.h"
#import "Blindside.h"
#import "Dependancy.h"


@implementation InjectorProvider

+ (id <BSInjector>)injector {
    NSArray *modules = @[[[Dependancy alloc] init]];

    return [Blindside injectorWithModules:modules];
}

@end
