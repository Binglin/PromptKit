//
//  PromptUIDataSource.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "PKPromptUIDataSource.h"
#import "PKSetting.h"

@implementation PKPromptUIDataSource

+ (instancetype)defaultEmptyEntity{
    return [PKSetting Default].empty;
}

+ (instancetype)defaultErrorEntity{
    return [PKSetting Default].error;
}

- (instancetype)initWithEmptyTitle:(NSString *)title{
    if (self = [super init]) {
        self.title = title;
        self.iconName = [PKSetting Default].empty.iconName;
    }
    return self;
}

- (instancetype)initWithErrorTitle:(NSString *)title{
    if (self = [super init]) {
        self.title = title;
        self.iconName = [PKSetting Default].error.iconName;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title logo:(NSString *)logoName{
    if (self = [super init]) {
        self.title = title;
        self.iconName = logoName;
    }
    return self;
}
@end



