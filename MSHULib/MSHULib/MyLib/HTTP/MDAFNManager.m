//
//  MDAFNManager.m
//  MSHULib
//
//  Created by 舒江波 on 2019/5/6.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDAFNManager.h"
#import "GTMBase64.h"

@interface MDAFNManager()
{
    AFHTTPRequestOperationManager *_manager;
    
}
@end

@implementation MDAFNManager
+ (MDAFNManager *) sharedHttpManager
{
    static dispatch_once_t pred;
    static MDAFNManager *_sharedHttpManager = nil;
    dispatch_once(&pred, ^{
        
        if (_sharedHttpManager == nil)
        {
            _sharedHttpManager = [[self alloc] init];
        }
    });
    
    return _sharedHttpManager;
}

#pragma mark - 请求头设置

- (void)setDefaultHeaders
{
    [_manager.requestSerializer setValue:@"application/json"
                      forHTTPHeaderField:@"Content-Type"];
    [_manager.requestSerializer setValue:@"text/html"
                      forHTTPHeaderField:@"Content-Type"];
}
- (void)setPostImageDefaultHeaders
{
    [_manager.requestSerializer setValue:@"multipart/form-data"
                      forHTTPHeaderField:@"Content-Type"];
}

#pragma mark - 网络请求对外接口

- (void) requestWithVersionWithNewFromAppStoreOfAppUrl:(NSString *)appUrl
                                        timeOutSeconds:(NSTimeInterval)timeOutSeconds
                                               success:(void (^) (id responseObject))success
                                               failure:(void (^) (NSError *error))failure
{
    [self setDefaultHeaders];
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [self requestHttpTimeOutSeconds:timeOutSeconds];
    
    [_manager GET:appUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{success(responseObject);});
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{failure(error);});
    }];
}

#pragma mark - 判断是否请求超时

- (void) requestHttpTimeOutSeconds:(NSTimeInterval)timeOutSeconds
{
    if (timeOutSeconds <= 0) {
        _manager.requestSerializer.timeoutInterval = AFN_TIMEOUT_SECONDS;
    } else {
        _manager.requestSerializer.timeoutInterval = timeOutSeconds;
    }
}
@end
