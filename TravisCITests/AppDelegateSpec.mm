#import "Cedar.h"
#import "AppDelegate.h"
#import "ViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *subject;

    beforeEach(^{

        subject = [[AppDelegate alloc] init];
        [subject application:nil didFinishLaunchingWithOptions:nil];
    });

    it(@"should set the root view controller of the window", ^{
        UINavigationController *rootViewController = (id)subject.window.rootViewController;
        rootViewController should_not be_nil;
        rootViewController should be_instance_of([UINavigationController class]);
        rootViewController.topViewController should be_instance_of([ViewController class]);

    });

    it(@"should display the window", ^{
        [subject.window isKeyWindow] should be_truthy;
    });
});

SPEC_END
