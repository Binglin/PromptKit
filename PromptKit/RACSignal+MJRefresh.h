//
//  RACSignal+MJRefresh.h
//
//
//  Created by ET|冰琳 on 16/6/22.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UIlistDataPullPushProtocol <NSObject>

@required
- (void)loadMore:(BOOL)more;

@end


@interface UIScrollView (PK_MJRefresh)
/**
 *  仅刷新
 *
 *  @param del <#del description#>
 */
- (void)uk_addRefresh:(id<UIlistDataPullPushProtocol>)del;

/**
 *  刷新 & 加载更多
 *
 *  @param del <#del description#>
 */
- (void)uk_addRefreshLoadMore:(id<UIlistDataPullPushProtocol>)del;

- (void)endRefresh:(BOOL)more;
- (void)updateFooterWithMoreData:(BOOL)more;

@end

@interface RACSignal (PK_MJRefresh)

/**
 *  管理刷新&加载更多的endRefresh
 *  @param refreshOrLoadMore 
           YES: 加载更多
           NO : 加载更多
 */
- (RACSignal *)pk_manageRefreshing:(UIScrollView *)scrollView more:(BOOL)refreshOrLoadMore;
- (RACSignal *)pk_manageRefreshing:(UIScrollView *)scrollView;

@end


