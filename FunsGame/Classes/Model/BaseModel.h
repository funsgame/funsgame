//
//  BaseModel.h
//  KinHop
//
//  Created by weibin on 14/11/24.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JTObjectMapping.h"
#import "MKNetworkEngine.h"
#import "LKDBHelper.h"

@class StatusArrModel;

typedef enum {
    NetworkHUDBackground=0,         //不锁屏，不提示
    NetworkHUDMsg=1,                //不锁屏，只要msg不为空就提示
    NetworkHUDError=2,              //不锁屏，提示错误信息
    NetworkHUDLockScreen=3,         //锁屏
    NetworkHUDLockScreenAndMsg=4,   //锁屏，只要msg不为空就提示
    NetworkHUDLockScreenAndError=5, //锁屏，提示错误信息
} NetworkHUD;

@class StatusModel;

@interface BaseModel : NSObject

#pragma mark - DB
/**
 *  登录帐号的数据库
 *  @return LKDBHelper
 */
+(LKDBHelper *)getUserLKDBHelper;

+(LKDBHelper *)getDefaultLKDBHelper;

/**
 *  默认的数据库  子类可以重写，默认已经登录用登录帐号数据库，没有则默认数据库
 *  @return LKDBHelper
 */
+(LKDBHelper *)getUsingLKDBHelper;

#pragma mark - map
/**
 *  获取映射表 子类重写
 *  @return 映射表
 */
+ (NSMutableDictionary*)getMapping;

/**
 *  映射方法
 *  @param object 字典对象
 *  @return 状态Model
 */
+ (StatusModel*)statusModelFromJSONObject:(id<JTValidJSONResponse>)object;

/**
 *  映射方法
 *  @param object object 字典对象
 *  @param statusKey 状态关键字
 *  @return 状态Model
 */
+ (StatusModel*)statusModelFromJSONObject:(id<JTValidJSONResponse>)object statusKey:(NSString*)statusKey;

/**
 *  映射方法
 *  @param object object 字典对象
 *  @param aClass rs对应的是哪个类
 *  @return 状态Model
 */
+ (StatusModel*)statusModelFromJSONObject:(id<JTValidJSONResponse>)object class:(Class)aClass;

/**
 *  映射方法
 *  @param object object 字典对象
 *  @param aClass rs对应的是哪个类
 *  @param statusKey 状态关键字
 *  @return 状态Model
 */
+ (StatusModel*)statusModelFromJSONObject:(id<JTValidJSONResponse>)object class:(Class)class statusKey:(NSString*)statusKey;

+ (StatusArrModel*)statusArrModelFromJSONObject:(id<JTValidJSONResponse>)object;

+ (StatusArrModel*)statusArrModelFromJSONObject:(id<JTValidJSONResponse>)object class:(Class)class;

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key;
+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key mapping:(NSMutableDictionary *)mapping;
#pragma mark - handle network data
/**
 *  上传文件
 *  @param path                相对路径
 *  @param params              参数
 *  @param filePaths           文件路径数组
 *  @param completionBlock     完成Block
 *  @param uploadProgressBlock 完成进度
 *  @return 操作对象
 */
+(MKNetworkOperation*)uploadDocumentFromPath:(NSString *)path
                                      params:(NSMutableDictionary *)params
                                   filePaths:(NSMutableDictionary*)filePaths
                                onCompletion:(void (^)(id data))completionBlock
                            onUploadProgress:(MKNKProgressBlock)uploadProgressBlock;

/**
 *  下载文件
 *  @param path                  绝对URL
 *  @param params                参数
 *  @param filePath              下载到哪个目录
 *  @param completionBlock       完成Block
 *  @param downloadProgressBlock 完成进度
 *  @return 操作对象
 */
+(MKNetworkOperation*)downloadDocumentFromPath:(NSString *)path
                                        params:(NSMutableDictionary *)params
                                      filePath:(NSString *)filePath
                                  onCompletion:(void (^)(id data))completionBlock
                              onUploadProgress:(MKNKProgressBlock)downloadProgressBlock;

/**
 *  post请求 NetworkHUD = NetworkHUDLockScreenAndMsg
 *  @param path            相对路径
 *  @param params          参数
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                              onCompletion:(void (^)(id data))completionBlock;

/**
 *  post请求 废弃
 *  @param path            相对路径
 *  @param params          参数
 *  @param isBackground    是否后台请求
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                              isBackground:(BOOL)isBackground
                              onCompletion:(void (^)(id data))completionBlock;

/**
 *  post请求
 *  @param path            相对路径
 *  @param params          参数
 *  @param networkHUD      HUD状态
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                                networkHUD:(NetworkHUD)networkHUD
                              onCompletion:(void (^)(id data))completionBlock;

/**
 *  post请求
 *  @param path            相对路径
 *  @param params          参数
 *  @param isPost          YES是POST请求，否则GET
 *  @param networkHUD      HUD状态
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                                    isPost:(BOOL)isPost
                                networkHUD:(NetworkHUD)networkHUD
                              onCompletion:(void (^)(id data))completionBlock;

/**
 *  post请求
 *  @param path            相对路径
 *  @param params          参数
 *  @param networkHUD      HUD状态
 *  @param target          目标UIViewController，用于addNet:,返回按钮按下会断开网络请求
 *  @param completionBlock 完成Block
 *  @return 操作对象
 */
+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                                networkHUD:(NetworkHUD)networkHUD
                                    target:(id)target
                              onCompletion:(void (^)(id data))completionBlock;

/**
 *  显示HUD状态
 *  @param response   response字典对象
 *  @param networkHUD HUD状态
 */
+ (void)handleResponse:(NSDictionary *)response
            networkHUD:(NetworkHUD)networkHUD;

@end
