//
//  PKSetting.m
//  Galaxy
//
//  Created by ET|冰琳 on 16/11/23.
//  Copyright © 2016年 UK. All rights reserved.
//

#import "PKSetting.h"

@implementation PKSetting

+ (instancetype)Default{
    static dispatch_once_t onceToken;
    static PKSetting *_globalPKSetting;
    dispatch_once(&onceToken, ^{
        _globalPKSetting = [PKSetting new];
    });
    return _globalPKSetting;
}

- (instancetype)init{
    if (self = [super init]) {
        self.empty = [PKPromptUIDataSource new];
        self.empty.title = @"空空如也";
        self.empty.iconName = @"pk_global_empty_icon";
        
        self.error = [PKPromptUIDataSource new];
        self.error.title = @"请求失败";
        self.error.iconName = @"pk_global_error_icon";
    }
    return self;
}

- (PKPromptView *)style{
    if (_style == nil) {
        
        _style = [[PKPromptView alloc] initWithFrame:CGRectZero];
        
        _style.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _style.titleLabel.textColor = [UIColor colorWithRed:(0x80) / 255.0 green:(0x7d)/255.0 blue:(0x6c)/255.0 alpha:1.0];
        
        _style.detailLabel.font = [UIFont systemFontOfSize:14.0];
        _style.detailLabel.textColor = [UIColor lightGrayColor];
        
        [_style.actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_style.actionBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    }
    return _style;
}

@end
