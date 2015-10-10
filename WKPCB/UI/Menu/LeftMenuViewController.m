//
//  WTALeftViewController.m
//  WTAZoomNavigationController
//
//  Created by Andrew Carter on 11/13/13.
//  Copyright (c) 2013 Andrew Carter. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "FMDBManager.h"
#import "GWUserCenterDefaultCell.h"
#import "SlideNavigationController.h"

#define kLeftMenuBackgroundColor  UIColorMakeRGB(243, 243, 243)

NSString * const WTATableCellIdentifier = @"WTATableCellIdentifier";

@interface LeftMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataRowSource;
@property (nonatomic, assign) BOOL didSelectInitialViewController;

@end

@implementation LeftMenuViewController

#pragma mark - UIViewController Overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    

    [super viewDidLoad];
    //238,79,49
    //参考颜色
    //http://woofeng.cn/inspiration/mobile/nav/nav_6845.html
    
    self.tableView.backgroundView = [[UIView alloc] init];
    self.tableView.backgroundColor = kLeftMenuBackgroundColor;
    self.view.backgroundColor=UIColorMakeRGB(243, 243, 243);
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:WTATableCellIdentifier];
    self.tableView.bounces=NO;
    
    //加载数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.dataRowSource=[[FMDBManager shareInstance] GetPCBCategories];
        if (self.dataRowSource&&[self.dataRowSource count]>0) {
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [self.tableView reloadData];
            });
        }
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
/***
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
***/
#pragma mark - UITableViewDatasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataRowSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PCBCategrory *entity=[self.dataRowSource objectAtIndex:section];
    return [entity hasChild]?[entity.childs count]:1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    PCBCategrory *entity=[self.dataRowSource objectAtIndex:section];
    if (![entity hasChild]) {
        if (section==0&&[[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
            return 20;
        }
        return 0;
    }
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /***
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WTATableCellIdentifier forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    PCBCategrory *entity=[self.dataRowSource objectAtIndex:indexPath.section];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    if (![entity hasChild]) {
        cell.textLabel.text=entity.CategoryName;
    }else{
        PCBCategrory *item=[entity.childs objectAtIndex:indexPath.row];
        cell.textLabel.text=item.CategoryName;
    }
    cell.textLabel.font=kWKFont;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = UIColorMakeRGB(224, 48, 50);
    
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bgview.opaque = YES;
    bgview.backgroundColor = UIColorMakeRGB(47, 47, 49);
    [cell setBackgroundView:bgview];
    **/
    static NSString *cellIdentifier=@"contactUsIdentifier";
    GWUserCenterDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GWUserCenterDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    [cell layoutUcAccessoryView];
    PCBCategrory *entity=[self.dataRowSource objectAtIndex:indexPath.section];
    if (![entity hasChild]) {
       cell.cellBackImageView.position =GWBaseCellGroundViewPositionSingle;
       cell.ucTextLabel.text =entity.CategoryName;
    }else{
        if (indexPath.row ==0) {
            cell.cellBackImageView.position =GWBaseCellGroundViewPositionTop;
            if ([entity.childs count]==1) {
                cell.cellBackImageView.position =GWBaseCellGroundViewPositionSingle;
            }
        }else if(indexPath.row == [entity.childs count]-1){
            cell.cellBackImageView.position =GWBaseCellGroundViewPositionBottom;
        }else{
            cell.cellBackImageView.position =GWBaseCellGroundViewPositionMiddle;
        }
        PCBCategrory *item=[entity.childs objectAtIndex:indexPath.row];
        cell.ucTextLabel.text=item.CategoryName;
    }
    cell.accessoryImage =NO;
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PCBCategrory *entity=[self.dataRowSource objectAtIndex:section];
    if (![entity hasChild]) {
        return nil;
    }
    UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    headView.backgroundColor=[UIColor clearColor];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, headView.frame.size.width-10, headView.frame.size.height)];
    lab.backgroundColor=[UIColor clearColor];
    lab.font=[UIFont systemFontOfSize:14];
    //lab.textColor=UIColorMakeRGB(37, 37, 37);
    lab.textColor=[UIColor grayColor];
    lab.text=entity.CategoryName;
    [headView addSubview:lab];
    return headView;
    //240,240,240
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
    
    PCBCategrory *entity=[self.dataRowSource objectAtIndex:indexPath.section];
    if (entity.hasChild) {
        PCBCategrory *item=[entity.childs objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCategoryChanged" object:item];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCategoryChanged" object:entity];
    }
    //NSArray *arr=[[FMDBManager shareInstance] GetCategoryDetailWithType:entity.CategoryId];
    //NSLog(@"arr =%@",arr);
    
}

@end
