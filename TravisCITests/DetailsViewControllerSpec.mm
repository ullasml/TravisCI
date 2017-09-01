#import "Cedar.h"
#import "DetailsViewController.h"
#import "User.h"
#import "UIControl+Spec.h"
#import "Blindside.h"
#import "InjectorProvider.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(DetailsViewControllerSpec)

describe(@"DetailsViewController", ^{
    __block DetailsViewController *subject;
    __block User *user;
    __block id <DetailsViewControllerDelegate> delegate;
    __block id <BSInjector,BSBinder> injector;
    __block UINavigationController *navigationController;

    beforeEach(^{
        injector = [InjectorProvider injector];
        user = nice_fake_for([User class]);
        delegate = nice_fake_for(@protocol(DetailsViewControllerDelegate));
        subject = [injector getInstance:[DetailsViewController class]];
        [subject setUpWithUser:user delegate:delegate];

        navigationController = [[UINavigationController alloc]initWithRootViewController:subject];
        spy_on(navigationController);
    });

    describe(@"When the delete action on user is intiated", ^{
        beforeEach(^{
            subject.view should_not be_nil;
            [subject.deleteButton tap];
        });

        it(@"should inform its delegate to delete the user", ^{
            delegate should have_received(@selector(detailsViewController:deleteUser:)).with(subject,user);
        });
        it(@"should pop the viewcontroller from navigation stack", ^{
            navigationController should have_received(@selector(popViewControllerAnimated:));
        });


    });
});

SPEC_END
