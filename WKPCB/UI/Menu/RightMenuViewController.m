//
//  RightMenuViewController.m
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-9.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "RightMenuViewController.h"
#import "ContactUSViewController.h"
#import "GWUserCenterDefaultCell.h"
@interface RightMenuViewController ()

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人中心";
    self.listData=[NSArray arrayWithObjects:@"在线升级",@"关于我", nil];
    
    self.settingTableView.backgroundView = [[UIView alloc] init];
    self.settingTableView.backgroundColor = UIColorMakeRGB(243, 243, 243);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDatasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"centerIdentifier";
    GWUserCenterDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GWUserCenterDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    [cell layoutUcAccessoryView];
    
    cell.cellBackImageView.position =GWBaseCellGroundViewPositionMiddle;
    if (indexPath.row ==0) {
        cell.cellBackImageView.position =GWBaseCellGroundViewPositionTop;
    }else if(indexPath.row == [self.listData count]-1){
        cell.cellBackImageView.position =GWBaseCellGroundViewPositionBottom;
    }
    cell.accessoryImage =NO;
    cell.ucTextLabel.text =[self.listData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        ContactUSViewController *contactUS=[[ContactUSViewController alloc] initWithNibName:@"ContactUSViewController" bundle:nil];
        [[SlideNavigationController sharedInstance] pushViewController:contactUS animated:YES];
        //[self.navigationController pushViewController:contactUS animated:YES];
    }
}

@end
