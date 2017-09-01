
#import "DetailsViewController.h"
#import "User.h"

@interface DetailsViewController ()
@property (nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) id <DetailsViewControllerDelegate> delegate;

@end

@implementation DetailsViewController

- (void)setUpWithUser:(User *)user delegate:(id <DetailsViewControllerDelegate>)delegate
{
    self.user = user;
    self.delegate = delegate;

}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(IBAction)deleteUser:(id)sender
{
    [self.delegate detailsViewController:self deleteUser:self.user];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
