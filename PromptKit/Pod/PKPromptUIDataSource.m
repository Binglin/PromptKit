//
//  PromptUIDataSource.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "PKPromptUIDataSource.h"

static  NSString * const PKDefaultEmptyTitle = @"空空如也";
static  NSString * const PKDefaultEmptyLogo  = @"pk_global_empty_icon";

static  NSString * const PKDefaultErrorTitle = @"请求失败";
static  NSString * const PKDefaultErrorLogo  = @"pk_global_error_icon";


static PKPromptUIDataSource *_defaultEmptyEntity = nil;
static PKPromptUIDataSource *_defaultErrorEntity = nil;


@implementation PKPromptUIDataSource

+ (instancetype)defaultEmptyEntity{
    
    if (_defaultEmptyEntity) {
        return _defaultEmptyEntity;
    }

    PKPromptUIDataSource *empty = [PKPromptUIDataSource new];
    empty.title     = PKDefaultEmptyTitle;
    empty.iconName  = PKDefaultEmptyLogo;
    return empty;
}

+ (instancetype)defaultErrorEntity{
    
    if (_defaultErrorEntity) {
        return _defaultErrorEntity;
    }
    
    PKPromptUIDataSource *error = [PKPromptUIDataSource new];
    error.title     = PKDefaultErrorTitle;
    error.iconName  = PKDefaultErrorLogo;
    return error;
}

- (instancetype)initWithEmptyTitle:(NSString *)title{
    if (self = [super init]) {
        self.title = title;
        self.iconName = PKDefaultEmptyLogo;
    }
    return self;
}

- (instancetype)initWithErrorTitle:(NSString *)title{
    if (self = [super init]) {
        self.title = title;
        self.iconName = PKDefaultErrorLogo;
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

+ (void)setDefaultEmptyEntity:(PKPromptUIDataSource *)entity{
    _defaultEmptyEntity = entity;
}

+ (void)setDefaultErrorEntity:(PKPromptUIDataSource *)entity{
    _defaultErrorEntity = entity;
}
@end



