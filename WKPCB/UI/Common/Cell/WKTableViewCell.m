//
//  WKTableViewCell.m
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-11.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "WKTableViewCell.h"
#import "Masonry.h"
@implementation WKTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellBackgroundType:(WKTableViewCellBackgroundType)backgroundType{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        /**
         * 设置cell 圆角背景图
         */
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
            UIImageView *bgView=[[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 48.0f)];
            [bgView setImage:[self GetCellBackgroundWithType:backgroundType]];
            
            [self.contentView addSubview:bgView];
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(10.0f);
                make.right.equalTo(self.mas_right).offset(-10.0f);
                make.top.equalTo(self.mas_top);
                //make.height.equalTo(48.0f);
            }];
        }else{
           UIImageView *bgView=[[UIImageView alloc] init];
           [bgView setImage:[self GetCellBackgroundWithType:backgroundType]];
           self.backgroundView=bgView;
        }

        //选中颜色
        UIView *selectedView=[[UIView alloc] init];
        selectedView.backgroundColor=UIColorMakeRGB(232, 230, 222);
        self.selectedBackgroundView=selectedView;
    }
    return self;
}
- (void)awakeFromNib {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (UIImage*)GetCellBackgroundWithType:(WKTableViewCellBackgroundType)backgroundType{
   NSString *imgName=@"";
    if (backgroundType==WKTableViewCellBackgroundTop) {
        imgName=@"cell_top.png";
    }else if (backgroundType==WKTableViewCellBackgroundMiddle){
       imgName=@"cell_middle.png";
    }
    else if (backgroundType==WKTableViewCellBackgroundBottom){
        imgName=@"cell_bottom.png";
    }else{
        imgName=@"cell_whole.png";
    }
    UIImage *img=[UIImage imageNamed:imgName];
    img=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    return img;
}
@end
