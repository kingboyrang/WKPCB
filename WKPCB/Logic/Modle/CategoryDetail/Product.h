//
//  Product.h
//  WKPCB
//
//  Created by wulanzhou-mini on 15-3-4.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property (nonatomic,assign) NSInteger ProductId;
@property (nonatomic,assign) NSInteger Category;
@property (nonatomic,strong) NSString *ProductName;
@property (nonatomic,strong) NSString *ProductModel;
@property (nonatomic,strong) NSString *ImageURL;
@property (nonatomic,strong) NSString *Description;
@property (nonatomic,strong) NSString *Parameters;

- (NSString*)GetProductModelDesc;
- (NSString*)GetParametersDesc;

@end
