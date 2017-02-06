//
//  PrompKitProtocol.h
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKPromptUIDataSource.h"

@protocol PKPrompKitProtocol <NSObject>

- (UIView *) prompKitContainerView;

@end


@protocol PKLoadingViewProtocol <NSObject>

- (void)pk_showLoading;
- (void)pk_hideLoading;

@end



@protocol PKEmptyViewProtocol <NSObject>

- (void)pk_showEmpty:(PKPromptUIDataSource *)data;
- (void)pk_hideEmpty;

@end





/**
 *  错误页面完显示策略
 *
 *  页面为空时 数据加载失败可重新加载
 *  页面非空时 数据加载失败可toast提示
 */

@protocol PKErrorViewProtocol <NSObject>

- (void)pk_showError:(PKPromptUIDataSource *)data;
- (void)pk_hideError;

@end




@protocol PKErrorToastProtocol <NSObject>

- (void)pk_showToastText:(NSString *)text;
- (void)pk_showToast:(PKPromptUIDataSource *)data;
- (void)pk_hideToast;

@end

