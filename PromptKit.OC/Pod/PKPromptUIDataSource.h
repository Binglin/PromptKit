//
//  PromptUIDataSource.h
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKPromptUIDataSource : NSObject

@property (nonatomic, copy  ) NSString        *title;
@property (nonatomic, copy  ) NSString        *iconName;

@property (nonatomic, copy  ) NSString        *detailTitle;

@property (nonatomic, copy  ) dispatch_block_t reloadExecution;
@property (nonatomic, copy  ) NSString         *btnTitle;


+ (instancetype)defaultEmptyEntity;
+ (instancetype)defaultErrorEntity;


- (instancetype)initWithEmptyTitle:(NSString *)title;
- (instancetype)initWithErrorTitle:(NSString *)title;


- (instancetype)initWithTitle:(NSString *)title logo:(NSString *)logoName;

@end



