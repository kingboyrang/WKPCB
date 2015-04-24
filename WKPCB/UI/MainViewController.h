//
//  WTAContentViewController.h
//  WTAZoomNavigationController
//
//  Created by Andrew Carter on 11/13/13.
//  Copyright (c) 2013 Andrew Carter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface MainViewController : UIViewController<SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSInteger  _curCategoryId;
}
@property (weak, nonatomic) IBOutlet UITableView *productTable;
@property (strong,nonatomic) NSArray *listData;
@end
