

#import <UIKit/UIKit.h>
#import "DetailsViewController.h"

@class DataRepository;


@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, DetailsViewControllerDelegate>

@property (nonatomic, readonly) DataRepository *dataRepository;

@property (nonatomic, weak, readonly) UITableView *tableView;


+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDataDictionary:(NSDictionary *)dictionary  UNAVAILABLE_ATTRIBUTE;
- (id)initWithCoder:(NSCoder *)aDecoder UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil UNAVAILABLE_ATTRIBUTE;

-(instancetype)initWithDataRepository:(DataRepository *)dataRepository NS_DESIGNATED_INITIALIZER;
@end
