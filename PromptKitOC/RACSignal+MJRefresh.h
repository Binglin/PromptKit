//
//  RACSignal+MJRefresh.h
//
//
//  Created by ET|冰琳 on 16/6/22.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@protocol UIlistPullPushProtocol <NSObject>

@required
- (void)loadMore:(BOOL)more;

@end


@interface UIScrollView (PK_MJRefresh)
/**
 *  仅刷新
 *
 *  @param del <#del description#>
 */
- (void)pk_addRefresh:(id<UIlistPullPushProtocol>)del;

/**
 *  刷新 & 加载更多
 *
 *  @param del <#del description#>
 */
- (void)pk_addRefreshLoadMore:(id<UIlistPullPushProtocol>)del;

- (void)pk_beginRefreshing;
- (void)pk_endRefresh:(BOOL)more;
- (void)pk_updateFooterWithMoreData:(BOOL)more;

@end

@interface RACSignal (PK_MJRefresh)

/**
 *  管理刷新&加载更多的
 *  @param refreshOrLoadMore 
           YES: 加载更多
           NO : 加载更多
 */
- (RACSignal *)pk_manageRefreshing:(UIScrollView *)scrollView more:(BOOL)refreshOrLoadMore;


/**
 *  仅刷新 管理 适用于页面只管理刷新逻辑的情况
 */
- (RACSignal *)pk_manageRefreshing:(UIScrollView *)scrollView;

@end


