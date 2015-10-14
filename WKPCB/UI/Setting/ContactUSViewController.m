//
//  ContactUSViewController.m
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-11.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "ContactUSViewController.h"
#import "CompanyMapViewController.h"
#import "WKTableViewCell.h"
#import "GWUserCenterDefaultCell.h"
#import "ActionSheetHelper.h"
#import <MessageUI/MessageUI.h>
@interface ContactUSViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation ContactUSViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于我";
    
    self.contactTableView.backgroundView = [[UIView alloc] init];
    self.contactTableView.backgroundColor =UIColorMakeRGB(243, 243, 243);
    //22.542264,114.085947
    
    NSMutableArray *sources=[NSMutableArray arrayWithCapacity:0];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"地址:",@"name",@"深圳市福田区华强广场Q1A024",@"value", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"联系人:",@"name",@"孙海峰",@"value", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"电话:",@"name",@"13632706906",@"value", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"传真:",@"name",@"0755-83294906",@"value", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"E-mail:",@"name",@"pcb-a@163.com",@"value", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"QQ:",@"name",@"65636969",@"value", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"版本:",@"name",@"v1.0.0",@"value", nil]];
    self.listData=sources;
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
    static NSString *cellIdentifier=@"contactUsIdentifier";
    GWUserCenterDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GWUserCenterDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row!=1&&indexPath.row!=[self.listData count]-1&&indexPath.row!=[self.listData count]-2) {
            //NSLog(@"row =%d",indexPath.row);
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    [cell layoutUcAccessoryView];
    
    if (indexPath.row ==0) {
        cell.cellBackImageView.position =GWBaseCellGroundViewPositionTop;
    }else if(indexPath.row == [self.listData count]-1){
        cell.cellBackImageView.position =GWBaseCellGroundViewPositionBottom;
    }else{
        cell.cellBackImageView.position =GWBaseCellGroundViewPositionMiddle;
    }
    cell.accessoryImage =NO;
    NSDictionary *dic=[self.listData objectAtIndex:indexPath.row];
    cell.ucTextLabel.text =[dic objectForKey:@"name"];
    cell.ucRightTextLabel.text=[dic objectForKey:@"value"];
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSDictionary *dic=[self.listData objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        CompanyMapViewController *map=[[CompanyMapViewController alloc] initWithNibName:@"CompanyMapViewController" bundle:nil];
        [self.navigationController pushViewController:map animated:YES];
    }
    if (indexPath.row==2||indexPath.row==3) {
        
        [ActionSheetHelper showSheetInView:self.view confirmTitle:[NSString stringWithFormat:@"拨打%@",[dic objectForKey:@"value"]] confirmAction:^{
            // 系统拨打
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", [dic objectForKey:@"value"]]]];
        }];
    }
    if (indexPath.row==4) {
        NSString *email=[dic objectForKey:@"value"];
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *emailer = [[MFMailComposeViewController alloc] init];
            emailer.navigationBar.tintColor=[UIColor blackColor];
            [emailer.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
            emailer.mailComposeDelegate = self;
            // 添加发送者
            NSArray *toRecipients = [NSArray arrayWithObject:email];
            [emailer setToRecipients: toRecipients];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                emailer.modalPresentationStyle = UIModalPresentationPageSheet;
            }
            [self presentViewController:emailer animated:YES completion:nil];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未设置邮件帐号,无法发送邮件!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //msg = @"郵件發送取消";
            break;
        case MFMailComposeResultSaved:
            //msg = @"郵件儲存成功";
            //[self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            //[AlertHelper initWithTitle:@"提示" message:@"郵件發送成功!"];
            //[self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            //msg = @"郵件發送失敗";
            //[self alertWithTitle:nil msg:msg];
            //[AlertHelper initWithTitle:@"提示" message:@"郵件發送失敗!"];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
