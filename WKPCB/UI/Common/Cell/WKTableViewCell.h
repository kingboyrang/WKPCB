//
//  WKTableViewCell.h
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-11.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
   WKTableViewCellBackgroundTop=0,
   WKTableViewCellBackgroundMiddle,
   WKTableViewCellBackgroundBottom,
   WKTableViewCellBackgroundWhole
}WKTableViewCellBackgroundType;

@interface WKTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellBackgroundType:(WKTableViewCellBackgroundType)backgroundType;
@end
