

#import "ViewController.h"
#import "DataRepository.h"
#import "KSPromise.h"
#import "User.h"
#import "DetailsViewController.h"
#import "BSInjector.h"

@interface ViewController ()

@property (nonatomic) DataRepository *dataRepository;
@property (nonatomic) NSMutableArray *allUsers;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) id <BSInjector> injector;

@end

@implementation ViewController

- (instancetype)initWithDataRepository:(DataRepository *)dataRepository
{
    self = [super init];
    if (self) {
        self.dataRepository = dataRepository;
    }
    return self;
}

#pragma mark - NSObject

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"All users";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                          target:self
                                                                                          action:@selector(refreshAction)];
    [self reloadView];

}

- (void)refreshAction
{
    [self reloadView];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    User *user = self.allUsers[indexPath.row];
    cell.textLabel.text = [user name];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detailsViewController = [self.injector getInstance:[DetailsViewController class]];
    User *user = self.allUsers[indexPath.row];
    [detailsViewController setUpWithUser:user delegate:self];
    [self.navigationController pushViewController:detailsViewController animated:YES];

}

#pragma mark <DetailsViewControllerDelegate>

-(void)detailsViewController:(DetailsViewController *)detailsViewController deleteUser:(User *)user
{
    NSUInteger indexOfObject = [self.allUsers indexOfObject:user];
    if (indexOfObject != NSNotFound) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexOfObject inSection:0];
        [self.allUsers removeObjectAtIndex:indexOfObject];
        [self.tableView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Private

-(void)reloadView
{
    KSPromise *promise = [self.dataRepository getData];
    [promise then:^id(NSArray *allUsers) {
        self.allUsers = [allUsers mutableCopy];
        [self.tableView reloadData];
        return nil;
    } error:^id(NSError *error) {
        return nil;
    }];
}


@end
