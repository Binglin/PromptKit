//
//  UIScrollView+listHasData.h
//  Galaxy
//
//  Created by ET|冰琳 on 16/11/23.
//  Copyright © 2016年 UK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PKListCounter <NSObject>

- (BOOL)pk_hasRowsToDisplay;

@end

@interface UIScrollView (listHasData)

@end


@interface UITableView (PKListCounter) <PKListCounter>

@end




@interface UICollectionView (PKListCounter) <PKListCounter>

@end
