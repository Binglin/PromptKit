//
//  ViewController.m
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

#import "RootViewController.h"
#import "PromptKit.h"
#import "ExampleViewModel.h"

@interface RootViewController ()<UIlistPullPushProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)   ExampleViewModel *viewModel;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.tableFooterView = [UIView new];
    
    [PKSetting Default].empty.iconName = @"empty_logo";
    [PKSetting Default].error.iconName = @"error_offline";
    
    [self.tableView pk_addRefresh:self];
    
    [self setUpViewModel];
    
    [self loadMore:NO];
}

- (void)setUpViewModel{
    self.viewModel = [ExampleViewModel new];
}

- (void)loadMore:(BOOL)more{
    
    PKPromptUIDataSource *emptyUIData = [[PKPromptUIDataSource alloc] initWithEmptyTitle:@"aha, nothing display here"];
    
    @weakify(self);
    [[[[[[self.viewModel exampleURLRequest]
       
         pk_addLoading:self]
       
        pk_manageRefreshing:self.tableView more:more]
       
       pk_observerError:self.tableView reload:^{
           @strongify(self);
           [self loadMore:more];
       }]
      
      pk_observerEmpty:self.tableView emptyData:emptyUIData]
     
     subscribeNext:^(id x) {
        
    }];
}

@end
