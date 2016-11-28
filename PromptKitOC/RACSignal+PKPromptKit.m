//
//  RACSignal+PromptKit.m
//
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "RACSignal+PKPromptKit.h"
#import "PKPrompKitProtocol.h"
#import "UIScrollView+PKListCounter.h"

@implementation RACSignal (PKPromptKit)


#pragma mark - empty
- (RACSignal *)pk_addLoading:(id<PKLoadingViewProtocol>)del{
    
    [del pk_showLoading];
    
    return
    
    [[self doError:^(NSError *error) {
        [del pk_hideLoading];
    }] doNext:^(id x) {
        [del pk_hideLoading];
    }];
}

#pragma mark - error
- (RACSignal *)pk_observerError:(id<PKErrorViewProtocol>)del reload:(dispatch_block_t)reloadExcution{
    
    [del pk_hideError];
    return [[self doNext:^(id x) {
        [del pk_hideError];
    }] doError:^(NSError *error) {
        
        BOOL listHasData = NO;
        
        if ([del conformsToProtocol:@protocol(PKListCounter)]) {
            id<PKListCounter> counter = (id<PKListCounter>)del;
            listHasData = [counter pk_hasRowsToDisplay];
        }
        
        PKPromptUIDataSource *data = [PKPromptUIDataSource defaultErrorEntity];
        data.title = error.localizedDescription;
        data.reloadExecution = reloadExcution;
        
        if (listHasData) {
            if ([del conformsToProtocol:@protocol(PKErrorToastProtocol)]) {
                id<PKErrorToastProtocol> toastDel = (id<PKErrorToastProtocol>)del;
                [toastDel pk_showToast:data];
            }else{
                [del pk_showError:data];
            }
        }else{
            [del pk_showError:data];
        }
    }];
}


- (RACSignal *)pk_observerErrorToast:(id<PKErrorToastProtocol>)del{
    
    [del pk_hideToast];
    
    return [self doError:^(NSError *error) {
        
        PKPromptUIDataSource *data = [PKPromptUIDataSource defaultErrorEntity];
        data.title = error.localizedDescription;
        [del pk_showToast:data];
    }];
}

#pragma mark - empty

- (RACSignal *)pk_observerEmpty:(id<PKEmptyViewProtocol>)del
                      emptyData:(PKPromptUIDataSource *)data{
    
    [del pk_hideEmpty];
    
    return [[self doError:^(NSError *error) {
        [del pk_hideEmpty];
    }] doCompleted:^{
        
        BOOL morethan1 = NO;
        
        if ([del conformsToProtocol:@protocol(PKListCounter)]) {
            id<PKListCounter> counter = (id<PKListCounter>)del;
            morethan1 = [counter pk_hasRowsToDisplay];
        }
        
        if (morethan1) {
            [del pk_hideEmpty];
        }else{
            [del pk_showEmpty:data];
        }
    }];
}

@end
