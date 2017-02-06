//
//  ExampleViewModel.m
//  PromptKit
//
//  Created by ET|冰琳 on 2016/12/27.
//  Copyright © 2016年 IB. All rights reserved.
//

#import "ExampleViewModel.h"
#import "AFHTTPSessionManager+RACSignal.h"

@implementation ExampleViewModel

- (RACSignal *)exampleURLRequest{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.github.com/"]];
    
    return [manager rac_GET:@"search/users?q=Binglin" parameters:nil progress:nil];
}

@end
