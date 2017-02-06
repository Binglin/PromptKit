//
//  AFURLSessionManager+RACSignal.h
//  API
//
//  Created by ET|冰琳 on 16/11/24.
//  Copyright © 2016年 UK. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN
@interface AFURLSessionManager (RACSignal)


- (RACSignal *)rac_dataTaskWithRequest:(NSURLRequest *)request;

@end
NS_ASSUME_NONNULL_END
