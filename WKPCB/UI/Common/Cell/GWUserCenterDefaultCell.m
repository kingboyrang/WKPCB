//
//  GWUserCenterDefaultCell.m
//  GWMovie
//
//  Created by gewara10 on 13-11-29.
//  Copyright (c) 2013年 gewara. All rights reserved.
//

#import "GWUserCenterDefaultCell.h"
#import "Masonry.h"
//#import "MASConstraintMaker.h"

@implementation GWUserCenterDefaultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        /**
         * 设置cell 圆角背景图
         */
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
            self.cellBackImageView =[[GWBaseCellGroundView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 48.0f)];
            [self.contentView addSubview:self.cellBackImageView];
            [self.cellBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(10.0f);
                make.right.equalTo(self.mas_right).offset(-10.0f);
                make.top.equalTo(self.mas_top);
                //make.height.equalTo(48.0f);
            }];
        }else{
            self.cellBackImageView =[[GWBaseCellGroundView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 48.0f)];
            self.backgroundView =self.cellBackImageView;
        }
        
        
        
        /**
         * 设置cell Label
         */
        CGRect ucTextFrame =CGRectMake(20.0f, 15.0f,180.0f, 21.0f);
        self.ucTextLabel =[[UILabel alloc] initWithFrame:ucTextFrame];
        self.ucTextLabel.font =[UIFont systemFontOfSize:14.0f];
        self.ucTextLabel.textColor =[UIColor blackColor];
        self.ucTextLabel.textAlignment =NSTextAlignmentLeft;
        self.ucTextLabel.backgroundColor =[UIColor clearColor];
        self.ucTextLabel.adjustsFontSizeToFitWidth =YES;
        [self.cellBackImageView addSubview:self.ucTextLabel];
        
        /**
         *  设置 selectedBackgroundView 背景为 clearColor
         *  达到点击cell 高亮显示
         */
        self.selectedBackgroundView= [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor =[UIColor clearColor];
    }
    return self;
}

#pragma mark 
/**
 *  显示accesoryView
 */
- (void)layoutUcAccessoryView{
    
    /**
     * 设置cell accessoryView
     */
    
    
    CGRect ucAccessoryViewFrame =CGRectMake(0.0f, 0.0f,200.0f, 48.0f);
    self.ucAccessoryView =[[UIView alloc] initWithFrame:ucAccessoryViewFrame];
    self.ucAccessoryView.backgroundColor =[UIColor clearColor];
    self.accessoryView =self.ucAccessoryView;
    
    UIImage *arrowImage =[UIImage imageNamed:@"maparrow"];
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        self.arrowImageView =[[UIImageView alloc] initWithImage:arrowImage];
        self.arrowImageView.frame =CGRectMake(self.ucAccessoryView.frame.size.width -(arrowImage.size.width+10), 18.0f, arrowImage.size.width, arrowImage.size.height);
        self.arrowImageView.backgroundColor =[UIColor clearColor];
        [self.ucAccessoryView addSubview:self.arrowImageView];
    }
    
    CGRect ucRightFrame =CGRectMake(0.0f, 13.0f,self.ucAccessoryView.frame.size.width-(arrowImage.size.width+10), 21.0f);
    self.ucRightTextLabel =[[UILabel alloc] initWithFrame:ucRightFrame];
    self.ucRightTextLabel.font =[UIFont systemFontOfSize:14.0f];
    self.ucRightTextLabel.textColor =[UIColor lightGrayColor];
    self.ucRightTextLabel.textAlignment =NSTextAlignmentRight;
    self.ucRightTextLabel.backgroundColor =[UIColor clearColor];
    self.ucRightTextLabel.adjustsFontSizeToFitWidth =YES;
    [self.ucAccessoryView addSubview:self.ucRightTextLabel];
    /**
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        
        CGRect ucAccessoryViewFrame =CGRectMake(0.0f, 0.0f,200.0f, 48.0f);
        self.ucAccessoryView =[[UIView alloc] initWithFrame:ucAccessoryViewFrame];
        self.ucAccessoryView.backgroundColor =[UIColor clearColor];
        self.accessoryView =self.ucAccessoryView;
        
        UIImage *arrowImage =[UIImage imageNamed:@"maparrow"];
        self.arrowImageView =[[UIImageView alloc] initWithImage:arrowImage];
        self.arrowImageView.frame =CGRectMake(self.ucAccessoryView.frame.size.width -(arrowImage.size.width+10), 18.0f, arrowImage.size.width, arrowImage.size.height);
        self.arrowImageView.backgroundColor =[UIColor clearColor];
        [self.ucAccessoryView addSubview:self.arrowImageView];
        
        CGRect ucRightFrame =CGRectMake(0.0f, 13.0f,self.ucAccessoryView.frame.size.width-(self.arrowImageView.frame.size.width+10), 21.0f);
        self.ucRightTextLabel =[[UILabel alloc] initWithFrame:ucRightFrame];
        self.ucRightTextLabel.font =[UIFont systemFontOfSize:14.0f];
        self.ucRightTextLabel.textColor =[UIColor lightGrayColor];
        self.ucRightTextLabel.textAlignment =NSTextAlignmentRight;
        self.ucRightTextLabel.backgroundColor =[UIColor clearColor];
        self.ucRightTextLabel.adjustsFontSizeToFitWidth =YES;
        [self.ucAccessoryView addSubview:self.ucRightTextLabel];
    }else{
        [self.ucAccessoryView removeFromSuperview];
    }
     **/
}

-(void)setAccessoryImage:(BOOL)accessoryImage{
    [self layoutAccessoryImage:accessoryImage];
}

-(void)layoutAccessoryImage:(BOOL)isImage{
    
    if (isImage) {
        self.userImageView =[[UIImageView alloc] init];
        CGFloat right=self.bounds.size.width-self.ucRightTextLabel.frame.size.width-self.ucRightTextLabel.frame.origin.x;
        self.userImageView.frame = CGRectMake(right-40,7.0f, 38.f, 38.f);
        self.userImageView.layer.masksToBounds = YES;
        self.userImageView.layer.cornerRadius = 18;
        self.userImageView.layer.borderWidth =1.0f;
        //self.userImageView.layer.borderColor =[RGBACOLORFromRGBHex(0xa0a0a0) CGColor];
        [self.ucAccessoryView addSubview:self.userImageView];
        
    }
        /**
         *  头像框效果 因高亮后显示 背景 改用border
         
        self.userCoverImageView =[[UIImageView alloc] init];
        self.userCoverImageView.image =[UIImage imageNamed:@"edit_bk_portrait"];
        self.userCoverImageView.frame = CGRectMake(self.userImageView.left, 6.0f, 40.f, 40.f);
        self.userCoverImageView.backgroundColor =[UIColor clearColor];
        [self.ucAccessoryView addSubview:self.userCoverImageView];
    }else{
        [self.userCoverImageView removeFromSuperview];
        [self.userImageView removeFromSuperview];
    }
         */
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
