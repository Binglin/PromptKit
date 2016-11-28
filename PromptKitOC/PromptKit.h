//
//  PromptKit.h
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#ifndef PromptKit_h
#define PromptKit_h


/**
 *
 *  旨在app中 将网络请求相关的 loading  列表空 以及错误提示相关界面单独分裂出来  
 *  方便复用  各功能单一  可简单组合
 *  除了app中可统一处理相应逻辑外 自定义各个处理更灵活
 *
 */
#import "PKSetting.h"

#import "PKPromptKitEnums.h"
#import "PKPrompKitProtocol.h"
#import "PKPromptUIDataSource.h"

//View
#import "PKPromptView.h"
#import "PKBeansLoadingView.h"

//extenson
#import "RACSignal+PKPromptKit.h"
#import "UIViewController+PKPrompKit.h"
#import "RACSignal+MJRefresh.h"

/**
 *  app中相关的具体界面提示仅需要在PKPromptKit_APP.h中
 */
#import "UIView+PKPromptKit_APP.h"

#endif /* PromptKit_h */
