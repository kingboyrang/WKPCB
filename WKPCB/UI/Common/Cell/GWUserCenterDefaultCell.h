//
//  GWUserCenterDefaultCell.h
//  GWMovie
//
//  Created by gewara10 on 13-11-29.
//  Copyright (c) 2013年 gewara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWBaseCellGroundView.h"

@interface GWUserCenterDefaultCell : UITableViewCell

@property (strong, nonatomic) GWBaseCellGroundView *cellBackImageView;

@property (strong, nonatomic) UILabel *ucTextLabel;
@property (strong, nonatomic) UIView *ucAccessoryView;
@property (strong, nonatomic) UILabel *ucRightTextLabel;
@property (strong, nonatomic) UIImageView *arrowImageView;
@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UIImageView *userCoverImageView;
@property (assign, nonatomic) BOOL accessoryImage;

- (void)layoutUcAccessoryView;

- (void)layoutUcSubDetailView;
- (void)layoutUcSubDetailDisplay;
@end
