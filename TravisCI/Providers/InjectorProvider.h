#import <Foundation/Foundation.h>


@protocol BSInjector;
@protocol BSBinder;

@interface InjectorProvider : NSObject

+ (id<BSInjector,BSBinder>)injector;

@end
