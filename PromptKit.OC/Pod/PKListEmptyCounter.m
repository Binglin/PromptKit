//
//  UIScrollView+PKListCounter.m
//  Galaxy
//
//  Created by ET|冰琳 on 16/11/23.
//  Copyright © 2016年 UK. All rights reserved.
//

#import "PKListEmptyCounter.h"

@implementation UITableView (PKListCounter)

- (BOOL)pk_hasRowsToDisplay{
    if (self.numberOfSections > 0){
        for (int i = 0; i < self.numberOfSections; ++ i) {
            if ([self numberOfRowsInSection:i] > 0) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)pk_reloadDataAndCheckEmpty{
    
}

@end


@implementation UICollectionView (PKListCounter)

- (BOOL)pk_hasRowsToDisplay{

    if (self.numberOfSections > 0) {
        for (int i = 0 ; i < self.numberOfSections; ++ i) {
            if ([self numberOfItemsInSection:i] > 0) {
                return YES;
            }
        }
    }
    return NO;
}

@end
