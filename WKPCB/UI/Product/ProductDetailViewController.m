//
//  ProductDetailViewController.m
//  WKPCB
//
//  Created by wulanzhou on 15/10/14.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "GWUserCenterDefaultCell.h"
@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"产品详情";
    
    CGRect r=self.view.bounds;
    r.size.height-=[[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?64.0:44.0;
    self.detailTable=[[UITableView alloc] initWithFrame:r style:UITableViewStyleGrouped];
    self.detailTable.delegate=self;
    self.detailTable.dataSource=self;
    self.detailTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.detailTable.backgroundView = [[UIView alloc] init];
    self.detailTable.backgroundColor = UIColorMakeRGB(243, 243, 243);
    [self.view addSubview:self.detailTable];
    

    [self buildModels];
}

- (void)buildModels{
    NSMutableArray *sources=[NSMutableArray arrayWithCapacity:0];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"名称:",@"name",self.Entity.ProductName,@"value", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"型号:",@"name",[self.Entity GetProductModelDesc],@"value", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"产品参数:",@"name",[self.Entity GetParametersDesc],@"value", nil]];
    
    self.listData=sources;
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
    static NSString *cellIdentifier=@"detailIdentifier";
    GWUserCenterDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GWUserCenterDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView *bgView=[[UIView alloc] init];
        bgView.backgroundColor=[UIColor clearColor];
        cell.backgroundView = bgView;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
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


@end
