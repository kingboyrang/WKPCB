//
//  ContactUSViewController.h
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-11.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *contactTableView;

@property (nonatomic,strong) NSArray *listData;
@end
