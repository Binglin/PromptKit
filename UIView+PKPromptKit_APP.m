//
//  UIView+PromptKit_APP.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "UIView+PKPromptKit_APP.h"
#import "PKPromptView.h"
#import "PKBeansLoadingView.h"

#import "MiaoleGB-swift.h"

@implementation UIView (PKPromptKit)

- (UIView *)prompKitContainerView{
    return self;
}

@end


@implementation UIView (PKLoading)
    
    
- (void)pk_showLoading{
    LoadingView *loading ;
    
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleLoading];
    
    if ([view isKindOfClass:[LoadingView class]]){
        loading = (LoadingView *)view;
    }else{
        loading = [LoadingView maker];
        loading.tag = PKPromptUIStyleLoading;
        [self.prompKitContainerView addSubview:loading];
        loading.center = CGPointMake(self.prompKitContainerView.frame.size.width/2.0, self.prompKitContainerView.frame.size.height/2.0);
        [loading startAnimating];
    }
}
    
- (void)pk_hideLoading{
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleLoading];
    
    if ([view isKindOfClass:[LoadingView class]]){
        [(LoadingView *)view stopAnimating];
        [view removeFromSuperview];
    }
}

/*
- (void)pk_showBeansLoading{
    
    BeansLoadingView *loading ;
    
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleLoading];
    
    if ([view isKindOfClass:[BeansLoadingView class]]){
        loading = (BeansLoadingView *)view;
    }else{
        
        CGRect f = [UIScreen mainScreen].bounds;
        loading = [[BeansLoadingView alloc] initWithFrame:CGRectMake((CGRectGetWidth(f) - 100)/2, (CGRectGetHeight(f) - 64 - 50.0)/2.0, 100, 50)];//[LoadingView maker];
        loading.tag = PKPromptUIStyleLoading;
        [self.prompKitContainerView addSubview:loading];
        loading.center = CGPointMake(self.prompKitContainerView.frame.size.width/2.0, self.prompKitContainerView.frame.size.height/2.0);
        [loading startAnimating];
    }
}

- (void)pk_hideBeansLoading{
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleLoading];
    
    if ([view isKindOfClass:[BeansLoadingView class]]){
        [view removeFromSuperview];
    }
}
*/

@end


@implementation UIView (PKEmpty)

- (void)pk_showEmpty:(PKPromptUIDataSource *)data{
    
    PKPromptView *emptyView ;
    
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleEmpty];
    
    if ([view isKindOfClass:[PKPromptView class]]){
        emptyView = (PKPromptView *)view;
    }else{
        emptyView = [[PKPromptView alloc] initWithFrame:self.prompKitContainerView.bounds entity:data];
        emptyView.tag = PKPromptUIStyleEmpty;
        [self.prompKitContainerView addSubview:emptyView];
    }
}

- (void)pk_hideEmpty{
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleEmpty];
    
    if ([view isKindOfClass:[PKPromptView class]]){
        [view removeFromSuperview];
    }
}

@end


@implementation UIView (PKError)

#pragma mark - PKErrorViewProtocol

- (NSString *)errorString:(PKPromptUIDataSource *)error{
    return error.title;
}

- (void)pk_showError:(PKPromptUIDataSource *)error{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self _pk_showError:error];
    });
}

- (void)pk_hideError{
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleError];
    
    if ([view isKindOfClass:[PKPromptView class]]){
        [view removeFromSuperview];
    }
}


#pragma mark - PKErrorToastProtocol

- (void)pk_showToast:(PKPromptUIDataSource *)error{
    NSString *errorReason = [self errorString:error];
    [self pk_showToastText:errorReason];
}

- (void)pk_hideToast{
    [[HUDSinglaton shareSinglaton] hideHudOnView:self.prompKitContainerView];
}

- (void)pk_showToastText:(NSString *)text{
    [[HUDSinglaton shareSinglaton] showHUDThenHideWithText:text andView:self.prompKitContainerView];
}



#pragma mark - private
- (void)_pk_showError:(PKPromptUIDataSource *)errorInfo{
    
    PKPromptView *errorView ;
    
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleError];
    
    if ([view isKindOfClass:[PKPromptView class]]){
        errorView = (PKPromptView *)view;
    }else{
        errorView = [[PKPromptView alloc] initWithFrame:self.prompKitContainerView.bounds entity:errorInfo];
        errorView.tag = PKPromptUIStyleError;
        [self.prompKitContainerView addSubview:errorView];
    }
}

@end
