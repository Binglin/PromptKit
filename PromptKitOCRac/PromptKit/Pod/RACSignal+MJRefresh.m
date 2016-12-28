//
//  RACSignal+MJRefresh.m
//  
//
//  Created by ET|冰琳 on 16/6/22.
//  Copyright © 2016年 . All rights reserved.
//

#import "RACSignal+MJRefresh.h"
#import <MJRefresh/MJRefresh.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation UIScrollView (PK_MJRefresh)


-(void)pk_addRefresh:(id<UIlistPullPushProtocol>)del{
    [self pk_addRefreshHeaderView:del];
}

- (void)pk_addRefreshLoadMore:(id<UIlistPullPushProtocol>)del{
    [self pk_addRefreshHeaderView:del];
    [self pk_addRefreshFooterView:del];
}


- (void)pk_addRefreshHeaderView:(id<UIlistPullPushProtocol>)del{
    @weakify(del);
    MJRefreshNormalHeader *normalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(del);
        [del loadMore:NO];
    }];
    normalHeader.lastUpdatedTimeLabel.textColor = [UIColor blackColor];
    normalHeader.stateLabel.textColor = [UIColor grayColor];
    self.mj_header = normalHeader;
    [normalHeader beginRefreshing];
}

- (void)pk_addRefreshFooterView:(id<UIlistPullPushProtocol>)del{
    @weakify(del);
    MJRefreshBackStateFooter *normalFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(del);
        [del loadMore:YES];
    }];
    [normalFooter setTitle:@"没有更多了哦" forState:MJRefreshStateNoMoreData];
    normalFooter.stateLabel.textColor = [UIColor grayColor];
    self.mj_footer = normalFooter;
    self.mj_footer.hidden = YES;
}

- (void)pk_beginRefreshing{
    [self.mj_header beginRefreshing];
}

- (void)pk_endRefresh:(BOOL)more{
    if (more) {
        [self.mj_footer endRefreshing];
    }else{
        [self.mj_header endRefreshing];
    }
}

- (void)pk_updateFooterWithMoreData:(BOOL)more{
    if (more) {
        [self.mj_footer resetNoMoreData];
    }else{
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

@end

@implementation RACSignal (PK_MJRefresh)

- (RACSignal *)pk_manageRefreshing:(UIScrollView *)scrollView more:(BOOL)refreshOrLoadMore{
    return [[self doNext:^(id x) {
        [scrollView pk_endRefresh:refreshOrLoadMore];
    }] doError:^(NSError *error) {
        [scrollView pk_endRefresh:refreshOrLoadMore];
    }];
}

- (RACSignal *)pk_manageRefreshing:(UIScrollView *)scrollView{
    return [self pk_manageRefreshing:scrollView more:NO];
}

@end

