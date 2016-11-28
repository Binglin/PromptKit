//
//  RACSignal+PromptKit.h
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PKPrompKitProtocol.h"



/**
 *  所有的loading及空界面错误界面以及toast均加载以下del中
 *  如果del为viewController则界面会加在vc.view上
 *  如果del为view 
 *  则加在改view上
 
 *  所有特殊界面都已经处理了显示及消失逻辑 仅调用即可
 */
@interface RACSignal (PKPromptKit)


/**
 *  添加loading逻辑 Loading界面为Loading...
 */
- (RACSignal *)pk_addLoading:(id<PKLoadingViewProtocol> )del;


/**
 *  添加错误显示界面 同时提供一个重新操作原有操作(如请求等)
 *  @param reloadExcution 重新请求时需要进行的操作
 */
- (RACSignal *)pk_observerError:(id<PKErrorViewProtocol>)del
                         reload:(dispatch_block_t)reloadExcution;



/**
 *  添加错误提示 toast 适用于请求失败不能用errorView覆盖界面的情况 如登录等 如果被覆盖完全就没法操作了
 */
- (RACSignal *)pk_observerErrorToast:(id<PKErrorToastProtocol>)del;

/**
 *  处理界面需要显示空界面的时候使用 
 *  通常仅需要在需要加载更多的列表中使用
 *  在请求完成如果数据不为空 
 *  则可以自动隐藏空界面的显示
 *
 *  @param del  empty delegate
 *  @param data 空提示的文字logo等
 */
- (RACSignal *)pk_observerEmpty:(id<PKEmptyViewProtocol>)del
                      emptyData:(PKPromptUIDataSource *)data;

@end
