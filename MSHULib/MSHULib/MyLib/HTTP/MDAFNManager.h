//
//  MDAFNManager.h
//  MSHULib
//
//  Created by 舒江波 on 2019/5/6.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

// 服务器返回状态码
typedef NS_ENUM(NSUInteger, DirectBankingHttpStatus) {
    kHttpResponseNetWeakError     = 2001,//没有数据
    kHttpResponseNetError = 2007,//系统异常
    kHttpResponseNetDataBaseError = 3002,//访问服务器数据库失败
};

/*!
 *  @brief  AFNetworking数据请求方式
 */
typedef NS_ENUM(NSInteger, TAHttpRequestType){
    /*!
     *  @brief  post请求
     */
    kPostHttpRequest = 0,
    /*!
     *  @brief  get请求
     */
    kGetHttpRequest = 1
};

/*!
 *  @brief  手机设备网络状况
 */
typedef NS_ENUM(NSInteger, TAHttpReachabilityType){
    /*!
     *  @brief  wifi
     */
    kWifiHttpReachability = 0,
    /**
     *  @brief  2g
     */
    kTwoWanGetHttpReachability = 1,
    /**
     *  @brief  3g
     */
    kThreeWanGetHttpReachability = 2,
    /**
     *  @brief  4g
     */
    kFourWanGetHttpReachability = 3,
    /*!
     *  @brief  没网
     */
    kNotHttpReachability
};

#define HttpManager [TAHttpManager sharedHttpManager]
NS_ASSUME_NONNULL_BEGIN

@interface MDAFNManager : NSObject
@property (assign, nonatomic) TAHttpReachabilityType httpReachability;

/**
 *  单例
 *
 *  @return 单利对象
 */
+ (MDAFNManager *) sharedHttpManager;

/**
 取消所有的网络请求
 */
-(void)deallocAllafn;

/*
 *  @brief  一般网络请求调用方法
 *
 *  @param urlString       需要的urlString
 *  @param target          判断登录的页面
 *  @param timeOutSeconds  网络请求超时时间，默认传0(30s)
 *  @param httpRequestType 网络请求类型
 *  @param parametersDic   参数字典
 *  @param securitedPostBodyed   参数字典是否加密，YES-加密，NO-不加密
 *  @param success         成功回调
 *  @param failure         失败回调
 */
- (void) requestWithUrl:(NSString *)urlString
                 target:(id)target
         timeOutSeconds:(NSTimeInterval)timeOutSeconds
        httpRequestType:(TAHttpRequestType)httpRequestType
          parametersDic:(NSDictionary *)parametersDic
     securitiedPostBody:(BOOL)securitedPostBodyed
                success:(void (^) (id responseObject))success
                failure:(void (^) (NSError *error))failure;

/*!
 *  @brief  上传图片网络请求调用方法
 *
 *  @param urlString       需要的urlString
 *  @param target          判断登录的页面
 *  @param timeOutSeconds  网络请求超时时间，默认传0(30s)
 *  @param parametersDic   参数字典
 *  @param imagePickerArray   图片参数数组
 *  @param success         成功回调
 *  @param failure         失败回调
 */
- (void) requestWithPostImageUrl:(NSString *)urlString
                          target:(id)target
                  timeOutSeconds:(NSTimeInterval)timeOutSeconds
                   parametersDic:(NSDictionary *)parametersDic
                imagePickerArray:(NSMutableArray *)imagePickerArray
                         success:(void (^) (id responseObject))success
                         failure:(void (^) (NSError *error))failure;

/*!
 *  @brief  AppStore版本检查
 *
 *  @param appUrl       AppStore的URL网址
 *  @param timeOutSeconds  网络请求超时时间，默认传0(30s)
 *  @param success         成功回调
 *  @param failure         失败回调
 */
- (void) requestWithVersionWithNewFromAppStoreOfAppUrl:(NSString *)appUrl
                                        timeOutSeconds:(NSTimeInterval)timeOutSeconds
                                               success:(void (^) (id responseObject))success
                                               failure:(void (^) (NSError *error))failure;

/**
 虹点加签
 
 @param dataDict <#dataDict description#>
 @return <#return value description#>
 */
- (NSDictionary *)securityHODHttpDictionary:(NSDictionary *)dataDict;



/*!
 *  @brief  一般网络请求调用方法
 *
 *  @param urlString       需要的urlString
 *  @param target          判断登录的页面
 *  @param timeOutSeconds  网络请求超时时间，默认传0(30s)
 *  @param httpRequestType 网络请求类型
 *  @param parametersDic   参数字典
 *  @param securitedPostBodyed   参数字典是否加密，YES-加密，NO-不加密
 *  @param success         成功回调
 *  @param failure         失败回调
 */
- (void) requestWithUrlrresponseWithXml:(NSString *)urlString
                                 target:(id)target
                         timeOutSeconds:(NSTimeInterval)timeOutSeconds
                        httpRequestType:(TAHttpRequestType)httpRequestType
                          parametersDic:(NSDictionary *)parametersDic
                     securitiedPostBody:(BOOL)securitedPostBodyed
                                success:(void (^) (id responseObject))success
                                failure:(void (^) (NSError *error))failure;

-(void)download:(void (^) (NSString *path))success;

@end

NS_ASSUME_NONNULL_END
