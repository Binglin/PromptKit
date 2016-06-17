//
//  RACSignal+PromptKit.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "RACSignal+PKPromptKit.h"
#import "PKPrompKitProtocol.h"

@implementation RACSignal (PKPromptKit)


#pragma mark - empty
- (RACSignal *)pk_addLoading:(id<PKLoadingViewProtocol>)del{
    
    [del pk_showLoading];

    return
    
    [[self doError:^(NSError *error) {
        [del pk_hideLoading];
    }] doCompleted:^{
        [del pk_hideLoading];
    }];
}

#pragma mark - error
- (RACSignal *)pk_observerError:(id<PKErrorViewProtocol>)del{
    [del pk_hideError];
    return
    
    [self doError:^(NSError *error) {
        
        PKPromptUIDataSource *data = [PKPromptUIDataSource defaultErrorEntity];
        data.title = error.localizedDescription;
        [del pk_showError:data];
    }];
}

- (RACSignal *)pk_observerError:(id<PKErrorViewProtocol>)del reload:(dispatch_block_t)reloadExcution{
    [del pk_hideError];
    return [self doError:^(NSError *error) {
        PKPromptUIDataSource *data = [PKPromptUIDataSource defaultErrorEntity];
        data.title = error.localizedDescription;
        data.reloadExecution = reloadExcution;
        [del pk_showError:data];
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


- (RACSignal *)pk_addLoadingAndObserverError:(id<PKLoadingViewProtocol,PKErrorViewProtocol>)del{
    return [[self pk_addLoading:del] pk_observerError:del];
}



#pragma mark - empty

- (RACSignal *)pk_observerEmpty:(id<PKEmptyViewProtocol>)del
                emptyDataSource:(PKPromptUIDataSource *)data{
    
    [del pk_hideEmpty];
    
    return [self doCompleted:^{
        
        BOOL morethan1 = NO;
        
        if ([del isKindOfClass:[UITableView class]]) {
            
            UITableView *table = (UITableView *)del;
            
            if (table.numberOfSections > 0){
                for (int i = 0; i < table.numberOfSections; ++ i) {
                    if ([table numberOfRowsInSection:i] > 0) {
                        morethan1 = YES;
                        break;
                    }
                }
            }
            
        }else if ([del isKindOfClass:[UICollectionView class]]){
            
            UICollectionView *v = (UICollectionView *)del;
            
            if (v.numberOfSections > 0) {
                for (int i = 0 ; i < v.numberOfSections; ++ i) {
                    if ([v numberOfItemsInSection:i] > 0) {
                        morethan1 = YES;
                        break;
                    }
                }
            }
        }
        
        if (morethan1) {
            [del pk_hideEmpty];
        }else{
            [del pk_showEmpty:data];
        }
    }];
}

@end
