//
//  AFURLSessionManager+RACSignal.m
//  API
//
//  Created by ET|冰琳 on 16/11/24.
//  Copyright © 2016年 UK. All rights reserved.
//

#import "AFURLSessionManager+RACSignal.h"

@implementation AFURLSessionManager (RACSignal)

- (RACSignal *)rac_dataTaskWithRequest:(NSURLRequest *)request{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSURLSessionDataTask * task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"\n[task.ERROR:] %@\n[Result     :] %@", request, error);
                [subscriber sendError:error];
            }else{
                NSLog(@"\n[task.SUCEED] %@\n[Result     :] %@", request, responseObject);
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
        }];
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
