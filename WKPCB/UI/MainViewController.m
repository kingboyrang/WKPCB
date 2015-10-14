//
//  WTAContentViewController.m
//  WTAZoomNavigationController
//
//  Created by Andrew Carter on 11/13/13.
//  Copyright (c) 2013 Andrew Carter. All rights reserved.
//

#import "MainViewController.h"
#import "ShareManager.h"
#import "RightMenuViewController.h"
#import "ElectronicItemCell.h"
#import "PCBCategrory.h"
#import "FMDBManager.h"
#import "UIImageView+WebCache.h"
#import "ProductDetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - UIViewController Overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    _curCategoryId=-1;
    
    self.title=@"FPC";
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"top_navigation_infoicon.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
    //返回事件
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    UIView *footer=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    self.productTable.tableFooterView=footer;
    //self.productTable

    /**
    UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame=CGRectMake(20, 80, 300, 44);
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(buttonShareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
     **/
    
    //加载数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.listData=[[FMDBManager shareInstance] GetCategoryDetailWithType:1];
        if (self.listData&&[self.listData count]>0) {
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [self.productTable reloadData];
            });
        }
    });
    
    
    //改变类别
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCategoryFinishd:) name:@"kNotificationCategoryChanged" object:nil];
   
}
- (void)receiveCategoryFinishd:(NSNotification*)notification{
    PCBCategrory *mod=(PCBCategrory*)[notification object];
    if (mod.CategoryId!=_curCategoryId) {
        self.title=mod.CategoryName;
        self.listData=[[FMDBManager shareInstance] GetCategoryDetailWithType:mod.CategoryId];
        
        [self.productTable reloadData];
    }
    
}
//设置
- (void)settingClick{
    RightMenuViewController *rightMenu = [[RightMenuViewController alloc] initWithNibName:@"RightMenuViewController" bundle:nil];
    [self.navigationController pushViewController:rightMenu animated:YES];
}
- (void)buttonShareClick:(id)sender{
    [[ShareManager shareInstance] shareMenuClickHandler:sender];
}
#pragma mark - Table Source & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"cellIdentifier";
    ElectronicItemCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"ElectronicItemCell" owner:self options:nil];
        if (nibs&&[nibs count]>0) {
            cell=(ElectronicItemCell*)[nibs objectAtIndex:0];
        }
    }
    Product *mod=[self.listData objectAtIndex:indexPath.row];
    cell.labName.text=mod.ProductName;
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:mod.ImageURL]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductDetailViewController *detail=[[ProductDetailViewController alloc] init];
    detail.Entity=[self.listData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


@end
