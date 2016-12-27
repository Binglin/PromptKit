//
//  UIScrollView+listHasData.h
//  Galaxy
//
//  Created by ET|冰琳 on 16/11/23.
//  Copyright © 2016年 UK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PKListEmptyCounter <NSObject>

- (BOOL)pk_hasRowsToDisplay;

- (void)pk_reloadDataAndCheckEmpty;

@end



@interface UITableView (PKListCounter) <PKListEmptyCounter>

@end




@interface UICollectionView (PKListCounter) <PKListEmptyCounter>

@end
