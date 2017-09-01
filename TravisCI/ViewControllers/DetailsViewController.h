

#import <UIKit/UIKit.h>

@class User;
@protocol DetailsViewControllerDelegate;

@interface DetailsViewController : UIViewController

@property (nonatomic, weak, readonly) UIButton *deleteButton;

- (void)setUpWithUser:(User *)user delegate:(id <DetailsViewControllerDelegate>)delegate;

@end

@protocol DetailsViewControllerDelegate <NSObject>

-(void)detailsViewController:(DetailsViewController *)detailsViewController deleteUser:(User *)user;

@end
