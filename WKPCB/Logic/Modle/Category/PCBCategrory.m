//
//  PCBCategrory.m
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-10.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "PCBCategrory.h"

@implementation PCBCategrory
- (BOOL)hasChild{
    if (self.childs&&[self.childs count]>0) {
        return YES;
    }
    return NO;
}
@end
