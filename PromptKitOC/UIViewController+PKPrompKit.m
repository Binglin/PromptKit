//
//  UIViewController+PrompKit.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "UIViewController+PKPrompKit.h"
#import "UIView+PKPromptKit_APP.h"

@implementation UIViewController (PKPrompKit)

#pragma mark - PrompKitProtocol
- (UIView *)prompKitContainerView{
    return self.view;
}

#pragma mark - PKLoadingViewProtocol
- (void)pk_showLoading{
    [self.prompKitContainerView pk_showLoading];
}

- (void)pk_hideLoading{
    [self.prompKitContainerView pk_hideLoading];
}

#pragma mark - PKEmptyViewProtocol
- (void)pk_showEmpty:(PKPromptUIDataSource *)data{
    [self.prompKitContainerView pk_showEmpty:data];
}

- (void)pk_hideEmpty{
    [self.prompKitContainerView pk_hideEmpty];
}


#pragma mark - PKErrorViewProtocol
- (void)pk_showError:(PKPromptUIDataSource *)error{
    [self.prompKitContainerView pk_showError:error];
}

- (void)pk_hideError{
    [self.prompKitContainerView pk_hideError];
}

- (void)pk_showToastText:(NSString *)text{
    [self.prompKitContainerView pk_showToastText:text];
}


#pragma mark - PKErrorToastProtocol
- (void)pk_showToast:(PKPromptUIDataSource *)error{
    [self.prompKitContainerView pk_showToast:error];
}

- (void)pk_hideToast{
    [self.prompKitContainerView pk_hideToast];
}

@end
