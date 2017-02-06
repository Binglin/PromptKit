//
//  AFHTTPSessionManager+RACSignal.h
//  API
//
//  Created by ET|冰琳 on 16/11/24.
//  Copyright © 2016年 UK. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN
@interface AFHTTPSessionManager (RACSignal)


- (RACSignal *)rac_dataTaskWithHTTPMethod:(NSString *)method
                                URLString:(NSString *)URLString
                               parameters:(id)parameters
                           uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                         downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress;;

- (RACSignal *)rac_GET:(NSString *)URLString parameters:(nullable id)parameters
              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress;


- (RACSignal *)rac_HEAD:(NSString *)URLString parameters:(nullable id)parameters;


- (RACSignal *)rac_POST:(NSString *)URLString parameters:(nullable id)parameters
               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress;


- (RACSignal *)rac_POST:(NSString *)URLString parameters:(nullable id)parameters
                constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress;



@end
NS_ASSUME_NONNULL_END
