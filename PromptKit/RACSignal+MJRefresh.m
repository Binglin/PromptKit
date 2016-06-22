//
//  RACSignal+MJRefresh.m
//  
//
//  Created by ET|冰琳 on 16/6/22.
//  Copyright © 2016年 . All rights reserved.
//

#import "RACSignal+MJRefresh.h"
#import <MJRefresh/MJRefresh.h>


@implementation UIScrollView (PK_MJRefresh)


-(void)uk_addRefresh:(id<UIlistDataPullPushProtocol>)del{
    [self addRefreshHeaderView:del];
}

- (void)uk_addRefreshLoadMore:(id<UIlistDataPullPushProtocol>)del{
    [self addRefreshHeaderView:del];
    [self addRefreshFooterView:del];
}


- (void)addRefreshHeaderView:(id<UIlistDataPullPushProtocol>)del{
    @weakify(del);
    MJRefreshNormalHeader *normalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(del);
        [del loadMore:NO];
    }];
    normalHeader.lastUpdatedTimeLabel.textColor = [UIColor blackContentColor];
    normalHeader.stateLabel.textColor = [UIColor blackContentColor];
    self.header = normalHeader;
    [normalHeader beginRefreshing];
}

- (void)addRefreshFooterView:(id<UIlistDataPullPushProtocol>)del{
    @weakify(del);
    MJRefreshBackStateFooter *normalFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(del);
        [del loadMore:YES];
    }];
    [normalFooter setTitle:@"没有更多了哦" forState:MJRefreshStateNoMoreData];
    normalFooter.stateLabel.textColor = [UIColor blackContentColor];
    self.footer = normalFooter;
    self.footer.hidden = YES;
}

- (void)endRefresh:(BOOL)more{
    if (more) {
        [self.footer endRefreshing];
    }else{
        [self.header endRefreshing];
    }
}

- (void)updateFooterWithMoreData:(BOOL)more{
    if (more) {
        [self.footer resetNoMoreData];
    }else{
        [self.footer endRefreshingWithNoMoreData];
    }
}

@end

@implementation RACSignal (PK_MJRefresh)

- (RACSignal *)pk_manageRefreshing:(UIScrollView *)scrollView more:(BOOL)refreshOrLoadMore{
    return [[self doNext:^(id x) {
        [scrollView endRefresh:refreshOrLoadMore];
    }] doError:^(NSError *error) {
        [scrollView endRefresh:refreshOrLoadMore];
    }];
}

- (RACSignal *)pk_manageRefreshing:(UIScrollView *)scrollView{
    return [self pk_manageRefreshing:scrollView more:NO];
}

@end

