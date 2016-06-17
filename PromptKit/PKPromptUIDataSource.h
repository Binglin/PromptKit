//
//  PromptUIDataSource.h
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKPromptKitEnums.h"

@interface PKPromptUIDataSource : NSObject

@property (nonatomic, copy  ) NSString        *title;
@property (nonatomic, copy  ) NSString        *iconName;
@property (nonatomic, assign) PKPromptUIStyle    style;
@property (nonatomic, copy  ) dispatch_block_t   reloadExecution;
@property (nonatomic, copy  ) NSString        *btnTitle;
@property (nonatomic, copy  ) NSString        *detailTitle;

+ (instancetype)defaultEmptyEntity;
+ (instancetype)defaultErrorEntity;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title emptyLogo:(NSString *)logoName;

@end
