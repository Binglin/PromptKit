//
//  ViewController.m
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/4.
//  Copyright © 2016年 IB. All rights reserved.
//

#import "ViewController.h"
#import "PromptKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)manageLoading{
    
    RACSignal *signal = [[RACSignal return:@(1)] delay:3];
    
    id<PKLoadingViewProtocol> del = self;
    
    [[signal pk_addLoading:del] subscribeNext:^(id x) {
        // next of signal
        
    }];
}

- (void)manageEmpty{
    
    PKPromptUIDataSource *empty = [[PKPromptUIDataSource alloc] initWithTitle:@"emptyTitle" logo:@"empty_logo_name"];
    
    RACSignal *signal = [RACSignal empty];
    
    id<PKEmptyViewProtocol> del = self;
    
    [[signal pk_observerEmpty:del emptyData:empty] subscribeNext:^(id x) {
        // next of signal
    }];
}


- (void)manageToast{
    RACSignal *signal = [RACSignal return:[NSError errorWithDomain:@"domin" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"toast error description"}]];
    
    id<PKErrorToastProtocol> del = self;
    
    [[signal pk_observerErrorToast:del] subscribeNext:^(id x) {
        // next of signal
    }];
}

- (void)manageError{
    
    RACSignal *signal = [RACSignal empty];
    
    id<PKErrorViewProtocol> del = self;
    
    [[signal pk_observerError:del reload:^{
        // action execute by tap button or view to reload when error occure
        
    }] subscribeNext:^(id x) {
        // next of signal
    }];
}

@end
