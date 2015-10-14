//
//  ProductDetailViewController.h
//  WKPCB
//
//  Created by wulanzhou on 15/10/14.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface ProductDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  UITableView *detailTable;

@property (nonatomic,strong) Product *Entity;

@property (nonatomic,strong) NSArray *listData;

@end
