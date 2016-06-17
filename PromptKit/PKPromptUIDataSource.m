//
//  PromptUIDataSource.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "PKPromptUIDataSource.h"

@implementation PKPromptUIDataSource

+ (instancetype)defaultEmptyEntity{
    PKPromptUIDataSource *d = [PKPromptUIDataSource new];
    d.style = PKPromptUIStyleEmpty;
    d.title = @"哎呀，啥都木有!";
    d.iconName = @"Global_empty_logo";
    return d;
}

+ (instancetype)defaultErrorEntity{
    PKPromptUIDataSource *d = [PKPromptUIDataSource new];
    d.style = PKPromptUIStyleError;
    d.title = @"点击界面重新加载";
    d.iconName = @"Global_error_logo";
    return d;
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        self.style = PKPromptUIStyleEmpty;
        self.iconName = @"Global_empty_logo";
        self.title = title;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title emptyLogo:(NSString *)logoName{
    if (self = [super init]) {
        self.style = PKPromptUIStyleEmpty;
        self.title = title;
        self.iconName = logoName;
    }
    return self;
}

@end
    