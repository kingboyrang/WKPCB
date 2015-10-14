//
//  Product.m
//  WKPCB
//
//  Created by wulanzhou-mini on 15-3-4.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "Product.h"

@implementation Product


- (NSString*)GetProductModelDesc{
    if ([self.ProductModel isKindOfClass:[NSString class]]&&self.ProductModel&&[self.ProductModel length]>0) {
        return self.ProductModel;
    }
    return @"";
}
- (NSString*)GetParametersDesc{
    if ([self.Parameters isKindOfClass:[NSString class]]&&self.Parameters&&[self.Parameters length]>0) {
        return self.Parameters;
    }
    return @"";
}


@end
