//
//  AFHTTPSessionManager+RACSignal.m
//  API
//
//  Created by ET|冰琳 on 16/11/24.
//  Copyright © 2016年 UK. All rights reserved.
//

#import "AFHTTPSessionManager+RACSignal.h"

@interface AFHTTPSessionManager()
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end


@implementation AFHTTPSessionManager (RACSignal)

- (RACSignal *)rac_dataTaskWithHTTPMethod:(NSString *)method
                                URLString:(NSString *)URLString
                               parameters:(id)parameters
                           uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                         downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:method
                                                            URLString:URLString
                                                           parameters:parameters
                                                       uploadProgress:nil
                                                     downloadProgress:downloadProgress
                                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                  NSLog(@"\n[%@: Succeed] %@\
                                                                          \n[Parameters:] %@\
                                                                          \n[Result:    ] %@", method, task.originalRequest.URL.absoluteString, parameters, responseObject);
                                                                  [subscriber sendNext:responseObject];
                                                                  [subscriber sendCompleted];
                                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                  NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                                                  NSError *appError = [NSError errorWithDomain:error.domain code:response.statusCode userInfo:error.userInfo];
                                                                  
                                                                  NSLog(@"\n[%@: Failed ] %@\
                                                                          \n[Parameters:] %@\
                                                                          \n[ERROR:     ] %@",method, task.originalRequest.URL.absoluteString, parameters, appError);
                                                                  [subscriber sendError:appError];
                                                              }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
        
    }];
}


- (RACSignal *)rac_GET:(NSString *)URLString parameters:(nullable id)parameters
              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress{
    return [self rac_dataTaskWithHTTPMethod:@"GET" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:downloadProgress];
}


- (RACSignal *)rac_HEAD:(NSString *)URLString parameters:(nullable id)parameters{
    return [self rac_dataTaskWithHTTPMethod:@"HEAD" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil];
}

- (RACSignal *)rac_POST:(NSString *)URLString parameters:(nullable id)parameters
               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress{
    
    return [self rac_dataTaskWithHTTPMethod:@"POST" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil];
}


- (RACSignal *)rac_POST:(NSString *)URLString parameters:(nullable id)parameters
constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSURLSessionDataTask *task = [self POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"\n[POST: Succeed] %@\
                  \n[Parameters:    ] %@\
                  \n[Result:        ] %@", task.originalRequest.URL.absoluteString, parameters, responseObject);

            
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"\n[POST: Failed] %@\
                  \n[Parameters:   ] %@\
                  \n[ERROR:        ] %@", task.originalRequest.URL.absoluteString, parameters, error);
            
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}


@end
