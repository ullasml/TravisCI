#import "Cedar.h"
#import "Blindside.h"
#import "ViewController.h"
#import "InjectorProvider.h"
#import "DataRepository.h"
#import "KSDeferred.h"
#import "User.h"
#import "UITableViewCell+Spec.h"
#import "DetailsViewController.h"
#import "UIBarButtonItem+Spec.h"
using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ViewControllerSpec)

describe(@"ViewController", ^{
    __block ViewController *subject;
    __block id <BSInjector, BSBinder> injector;
    __block DataRepository *dataRepository;
    __block DetailsViewController *detailsViewController;
    __block UINavigationController *navigationController;
    

    beforeEach(^{

        injector = [InjectorProvider injector];

        detailsViewController = [[DetailsViewController alloc]init];
        [injector bind:[DetailsViewController class] toInstance:detailsViewController];
        spy_on(detailsViewController);

        dataRepository = nice_fake_for([DataRepository class]);
        [injector bind:[DataRepository class] toInstance:dataRepository];
        
        subject = [injector getInstance:[ViewController class]];
        navigationController = [[UINavigationController alloc]initWithRootViewController:subject];
        spy_on(navigationController);
    });

    describe(@"When the view loads", ^{
        __block KSDeferred *serviceDeferred;
        beforeEach(^{

            serviceDeferred = [[KSDeferred alloc]init];
            dataRepository stub_method(@selector(getData)).and_return(serviceDeferred.promise);
            subject.view should_not be_nil;
        });

        it(@"should ask dataRepository for the data from server ", ^{
            subject.title should equal(@"All users");
        });

        it(@"should have the right bar button item", ^{
            subject.navigationItem.rightBarButtonItem should_not be_nil;
            subject.navigationItem.rightBarButtonItem.target should equal(subject);
        });

        it(@"should ask dataRepository for the data from server ", ^{
            dataRepository should have_received(@selector(getData));
        });

        context(@"When the data fetch is success", ^{
            __block id <UITableViewDataSource> tableViewDataSource;
            __block id <UITableViewDelegate> tableViewDelegate;
            __block User *userA;
            __block User *userB;
            beforeEach(^{
                spy_on(subject.tableView);
                tableViewDataSource = [subject.tableView dataSource];
                tableViewDelegate = [subject.tableView delegate];
                userA = nice_fake_for([User class]);
                userA stub_method(@selector(name)).and_return(@"This is User A");
                userB = nice_fake_for([User class]);
                userB stub_method(@selector(name)).and_return(@"This is User B");
                [serviceDeferred resolveWithValue:@[userA,userB]];
            });

            afterEach(^{
                stop_spying_on(subject.tableView);
            });

            it(@"should have the table datasource set correctly ", ^{
                tableViewDataSource should_not be_nil;
            });
            it(@"should have the table view", ^{
                subject.tableView should_not be_nil;
            });
            it(@"should reload the table view", ^{
                subject.tableView should have_received(@selector(reloadData));
            });

            it(@"should have the table reloaded with the correct number of sections ", ^{
                subject.tableView.numberOfSections should equal(1);
            });

            it(@"should have the table reloaded with the correct number of rows", ^{
                [tableViewDataSource tableView:subject.tableView numberOfRowsInSection:0] should equal(2);
            });

            it(@"should have the table reloaded with the correct number of rows", ^{

                NSIndexPath *firstIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
                UITableViewCell *firstTableCell = [tableViewDataSource tableView:subject.tableView cellForRowAtIndexPath:firstIndexpath];
                firstTableCell.textLabel.text should equal(@"This is User A");

                NSIndexPath *secondIndexpath = [NSIndexPath indexPathForRow:1 inSection:0];
                UITableViewCell *secondTableCell = [tableViewDataSource tableView:subject.tableView cellForRowAtIndexPath:secondIndexpath];
                secondTableCell.textLabel.text should equal(@"This is User B");
            });

            context(@"When cell is tapped", ^{

                beforeEach(^{
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    UITableViewCell *cell = [subject.tableView cellForRowAtIndexPath:indexPath];
                    [cell tap];
                });

                it(@"should set up the DetailsViewController correctly", ^{
                    detailsViewController should have_received(@selector(setUpWithUser:delegate:))
                    .with(userA,subject);
                });

                it(@"should navigate to the details controller", ^{
                    navigationController.topViewController should be_same_instance_as(detailsViewController);
                });

                it(@"should navigate to the TimesheetDetails screen", ^{
                    navigationController should have_received(@selector(pushViewController:animated:)).with(detailsViewController, YES);
                });

            });
        });

        context(@"When the data fetch is failure", ^{
            beforeEach(^{
                spy_on(subject.tableView);
                NSError *error;
                [serviceDeferred rejectWithError:error];
            });

            afterEach(^{
                stop_spying_on(subject.tableView);
            });

            it(@"should have no rows in the table view", ^{
                subject.tableView should_not have_received(@selector(reloadData));
            });
            it(@"should have no rows in the table view", ^{
                subject.tableView.visibleCells.count should equal(0);
            });
        });
    });

    describe(@"When refresh action is performed", ^{

        __block KSDeferred *serviceDeferred;
        __block UIBarButtonItem *refreshActionButton;
        beforeEach(^{
            serviceDeferred = [[KSDeferred alloc]init];
            dataRepository stub_method(@selector(getData)).and_return(serviceDeferred.promise);
            subject.view should_not be_nil;
            refreshActionButton = subject.navigationItem.rightBarButtonItem;
            [refreshActionButton tap];
        });

        it(@"should request the data repository for the data", ^{
            dataRepository should have_received(@selector(getData));
        });

        context(@"When the data fetch is success", ^{
            __block NSArray *arrayOfUsers;
            __block id <UITableViewDataSource> tableViewDataSource;
            __block id <UITableViewDelegate> tableViewDelegate;
            beforeEach(^{
                spy_on(subject.tableView);
                tableViewDataSource = [subject.tableView dataSource];
                tableViewDelegate = [subject.tableView delegate];
                User *userA = nice_fake_for([User class]);
                userA stub_method(@selector(name)).and_return(@"This is User A");
                User *userB = nice_fake_for([User class]);
                userB stub_method(@selector(name)).and_return(@"This is User B");
                arrayOfUsers = @[userA,userB];
                [serviceDeferred resolveWithValue:arrayOfUsers];
            });

            afterEach(^{
                stop_spying_on(subject.tableView);
            });

            it(@"should have the table datasource set correctly ", ^{
                tableViewDataSource should_not be_nil;
            });
            it(@"should have the table view", ^{
                subject.tableView should_not be_nil;
            });
            it(@"should reload the table view", ^{
                subject.tableView should have_received(@selector(reloadData));
            });

            it(@"should have the table reloaded with the correct number of sections ", ^{
                subject.tableView.numberOfSections should equal(1);
            });

            it(@"should have the table reloaded with the correct number of rows", ^{
                [tableViewDataSource tableView:subject.tableView numberOfRowsInSection:0] should equal(2);
            });

            it(@"should have the table reloaded with the correct number of rows", ^{

                NSIndexPath *firstIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
                UITableViewCell *firstTableCell = [tableViewDataSource tableView:subject.tableView cellForRowAtIndexPath:firstIndexpath];
                firstTableCell.textLabel.text should equal(@"This is User A");

                NSIndexPath *secondIndexpath = [NSIndexPath indexPathForRow:1 inSection:0];
                UITableViewCell *secondTableCell = [tableViewDataSource tableView:subject.tableView cellForRowAtIndexPath:secondIndexpath];
                secondTableCell.textLabel.text should equal(@"This is User B");
            });
        });

        context(@"When the data fetch is failure", ^{
            beforeEach(^{
                spy_on(subject.tableView);
                NSError *error;
                [serviceDeferred rejectWithError:error];
            });

            afterEach(^{
                stop_spying_on(subject.tableView);
            });

            it(@"should have no rows in the table view", ^{
                subject.tableView should_not have_received(@selector(reloadData));
            });
            it(@"should have no rows in the table view", ^{
                subject.tableView.visibleCells.count should equal(0);
            });
        });
    });

    describe(@"As a <DetailsViewControllerDelegate>", ^{
        __block KSDeferred *serviceDeferred;
        beforeEach(^{
            serviceDeferred = [[KSDeferred alloc]init];
            dataRepository stub_method(@selector(getData)).and_return(serviceDeferred.promise);
            subject.view should_not be_nil;
            spy_on(subject.tableView);

            User *userA = [[User alloc]initWithName:@"userA_name"
                                              email:@"userA_email"
                                              phone:@"userA_phone"
                                            website:@"userA_website"];

            User *userB = [[User alloc]initWithName:@"userB_name"
                                              email:@"userB_email"
                                              phone:@"userB_phone"
                                            website:@"userB_website"];

            [serviceDeferred resolveWithValue:@[userA,userB]];
            [subject detailsViewController:detailsViewController deleteUser:userA];
        });

        it(@"should delete the userA from the table view and display other users", ^{
            subject.tableView.visibleCells.count should equal(1);
            subject.tableView should have_received(@selector(deleteRowsAtIndexPaths:withRowAnimation:)).with(@[[NSIndexPath indexPathForRow:0 inSection:0]],UITableViewRowAnimationFade);
        });
    });
});

SPEC_END
