//
//  RightMenuViewController.h
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-9.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightMenuViewController : UIViewController
@property (nonatomic,strong) NSArray *listData;

@property (weak, nonatomic) IBOutlet UITableView *settingTableView;

@end
