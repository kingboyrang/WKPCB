//
//  ShareManager.h
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-11.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareManager : NSObject
+ (ShareManager *)shareInstance;
- (void)registerShare;
- (void)shareMenuClickHandler:(id)sender;
@end
