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
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIView (PKPromptKit)

- (UIView *)prompKitContainerView{
    return self;
}

@end


@implementation UIView (PKLoading)
    
    
- (void)pk_showLoading{
    //[SVProgressHUD show];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if(hud){
        [self addSubview:hud];
    }else{
        if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
            hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        }else{
            hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        }
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:HudDisapperTime];

}
    
- (void)pk_hideLoading{
    /*
    [SVProgressHUD dismiss];
     */
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if(hud){
        [hud hideAnimated:YES];
    }
}

@end


@implementation UIView (PKEmpty)

- (void)pk_showEmpty:(PKPromptUIDataSource *)data{
    
    PKPromptView *emptyView ;
    
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleEmpty];
    
    if ([view isKindOfClass:[PKPromptView class]]){
        emptyView = (PKPromptView *)view;
    }else{
        CGRect frame = self.prompKitContainerView.bounds;
        frame.origin.y = 0;
        if ([self isKindOfClass:[UITableView class]]) {
            UITableView *table = (UITableView *)self;
            if (table.tableHeaderView) {
                frame.origin.y = table.tableHeaderView.frame.size.height;
                frame.size.height -= frame.origin.y;
            }
        }
        emptyView = [[PKPromptView alloc] initWithFrame:frame];
        emptyView.tag = PKPromptUIStyleEmpty;
        [self.prompKitContainerView addSubview:emptyView];
    }
    [emptyView updateViewWithEntity:data];
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
    //[SVProgressHUD dismiss];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if(hud){
        [hud hideAnimated:YES];
    }
}

- (void)pk_showToastText:(NSString *)text{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if(hud){
        [self addSubview:hud];
    }else{
        if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
            hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        }else{
            hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        }
    }
    hud.detailsLabel.text = text;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

#pragma mark - private
- (void)_pk_showError:(PKPromptUIDataSource *)errorInfo{
    
    PKPromptView *errorView ;
    
    UIView *view = [self.prompKitContainerView viewWithTag:PKPromptUIStyleError];
    
    if ([view isKindOfClass:[PKPromptView class]]){
        errorView = (PKPromptView *)view;
    }else{
        
        CGRect frame = self.prompKitContainerView.bounds;
        if ([self isKindOfClass:[UITableView class]]) {
            UITableView *table = (UITableView *)self;
            if (table.tableHeaderView) {
                frame.origin.y = table.tableHeaderView.frame.size.height;
                frame.size.height -= frame.origin.y;
            }
        }
        errorView = [[PKPromptView alloc] initWithFrame:frame];
        errorView.tag = PKPromptUIStyleError;
        [self.prompKitContainerView addSubview:errorView];
    }
    [errorView updateViewWithEntity:errorInfo];
}

@end
