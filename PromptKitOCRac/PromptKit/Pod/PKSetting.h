//
//  PKSetting.h
//  Galaxy
//
//  Created by ET|冰琳 on 16/11/23.
//  Copyright © 2016年 UK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKSetting.h"
#import "PKPromptView.h"


/**
 global setting
 */
@interface PKSetting : NSObject

+ (instancetype)Default;

@property (nonatomic, strong) PKPromptUIDataSource  *empty;
@property (nonatomic, strong) PKPromptUIDataSource  *error;
@property (nonatomic, strong) PKPromptView          *style;

@end
