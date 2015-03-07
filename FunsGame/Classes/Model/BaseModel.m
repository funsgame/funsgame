//
//  BaseModel.m
//  KinHop
//
//  Created by weibin on 14/11/24.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "BaseModel.h"
#import "StatusModel.h"
#import "HttpsHeaderSetHepler.h"
#import "UUIDHelper.h"
#import "StatusArrModel.h"

//#import "RSA.h"

#define kKey @"1C7KETwwwW5gfz8VCCz0Lb9SeYRaBnzENvR7cLu9jczqEvadQZfuMTQKxco6WR56"

@implementation BaseModel

#pragma mark - DB
+(LKDBHelper *)getUserLKDBHelper
{
    static LKDBHelper* helper;
    static dispatch_once_t onceToken;
    NSString *dbName = [NSString stringWithFormat:@"kinhop_%@",[DataManager sharedManager].userId];
    dispatch_once(&onceToken, ^{
        helper = [[LKDBHelper alloc]initWithDBName:dbName];
    });
    [helper setDBName:[NSString stringWithFormat:@"%@.db",dbName]];
    return helper;
}

+(LKDBHelper *)getDefaultLKDBHelper
{
    static LKDBHelper* helper;
    static dispatch_once_t onceToken;
    NSString *dbName = @"kinhop_default";
    dispatch_once(&onceToken, ^{
        helper = [[LKDBHelper alloc]initWithDBName:dbName];
    });
    [helper setDBName:[NSString stringWithFormat:@"%@.db",dbName]];
    return helper;
}

+(LKDBHelper *)getUsingLKDBHelper
{
    LKDBHelper *helper;
    if (![NSString isNull:[DataManager sharedManager].userId]) {
        helper = [self getUserLKDBHelper];
    }else{
        helper = [self getDefaultLKDBHelper];
    }
    return helper;
}

//表版本
+(int)getTableVersion
{
    return 1;
}
//升级
+(LKTableUpdateType)tableUpdateForOldVersion:(int)oldVersion newVersion:(int)newVersion
{
    switch (oldVersion) {
            //        case 1:
            //        {
            //            [self tableUpdateAddColumnWithPN:@"color"];
            //        }
            //        case 2:
            //        {
            //            [self tableUpdateAddColumnWithName:@"address" sqliteType:LKSQL_Type_Text];
            //            //@"error" is removed
            //        }
            //            break;
    }
    return LKTableUpdateTypeDefault;
}

- (void)update{}

#pragma mark - map
+ (NSMutableDictionary*)getMapping
{
    return nil;
}

+ (StatusModel*)statusModelFromJSONObject:(id<JTValidJSONResponse>)object
{
    return [self statusModelFromJSONObject:object class:self];
}

+ (StatusModel*)statusModelFromJSONObject:(id<JTValidJSONResponse>)object class:(Class)class
{
    NSMutableDictionary *myMapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [class mappingWithKey:@"result"], @"result", nil];
    return [StatusModel objectFromJSONObject:object mapping:myMapping];
}

+ (StatusArrModel*)statusArrModelFromJSONObject:(id<JTValidJSONResponse>)object
{
    return [self statusArrModelFromJSONObject:object class:self];
}

+ (StatusArrModel*)statusArrModelFromJSONObject:(id<JTValidJSONResponse>)object class:(Class)class
{
    NSMutableDictionary *myMapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [class mappingWithKey:@"list"], @"list", nil];
    return [StatusArrModel objectFromJSONObject:object mapping:myMapping];
}

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key
{
    return [self mappingWithKey:key mapping:[self getMapping]];
}

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key mapping:(NSMutableDictionary *)mapping
{
    if (!mapping) {
        return [super mappingWithKey:key mapping:[self getMapping]];
    }
    return [super mappingWithKey:key mapping:mapping];
}

#pragma mark - network related methods
//上传文件
+(MKNetworkOperation*)uploadDocumentFromPath:(NSString *)path
                                      params:(NSMutableDictionary *)params
                                   filePaths:(NSMutableDictionary*)filePaths
                                onCompletion:(void (^)(id data))completionBlock
                            onUploadProgress:(MKNKProgressBlock)uploadProgressBlock{
    
    /*暂时不需要
     [self filtrateDictionary:params];
     */
    
    __block NSString *md5Key = nil;
    [filePaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSData *data = [NSData dataWithContentsOfFile:obj];
        NSString *base64 = [data base64EncodedString];
        NSString *md5 = [DataHelper getMd5_32Bit_String:base64 uppercase:YES];
        if (!md5Key) {
            md5Key = md5;
        }else{
            md5Key = [NSString stringWithFormat:@"%@,%@",md5Key,md5];
        }
    }];
    
    if (md5Key)
        [params setValue:md5Key forKey:@"validateKey"];
    
    NSMutableDictionary *myParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:[params jsonEncodedKeyValueString],@"json", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:kServerHost];
    MKNetworkOperation *op =[engine operationWithPath:path params:myParams httpMethod:@"POST" ssl:NO];
    DLog(@"url==%@\nparams==%@\n",op.url,params);
    [filePaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [op addFile:obj forKey:key];
    }];
    [op addCompletionHandler:^(MKNetworkOperation* operation) {
        NSString *responseString = [operation responseString];
        DLog(@"response==%@",responseString);
        id responseJson = [operation responseJSON];
        if (completionBlock)
            completionBlock(responseJson?responseJson:responseString);
    } errorHandler:^(MKNetworkOperation* completedOperation, NSError* error) {
        if (completionBlock){
            completionBlock([self getErrorDictionary]);
        }
    }];
    if (uploadProgressBlock) {
        [op onUploadProgressChanged:uploadProgressBlock];
    }
    
    [engine enqueueOperation:op];
    return op;
}

//下载文件
+(MKNetworkOperation*)downloadDocumentFromPath:(NSString *)path
                                        params:(NSMutableDictionary *)params
                                      filePath:(NSString *)filePath
                                  onCompletion:(void (^)(id data))completionBlock
                              onUploadProgress:(MKNKProgressBlock)downloadProgressBlock{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:kServerHost];
    MKNetworkOperation *op = [engine operationWithURLString:path params:params];
    
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath append:YES]];
    DLog(@"url==%@\nparams==%@\n",op.url,params);
    [op addCompletionHandler:^(MKNetworkOperation* operation) {
        NSString *responseString = [operation responseString];
        DLog(@"response==%@",responseString);
        if (completionBlock)
            completionBlock(responseString);
    } errorHandler:^(MKNetworkOperation* completedOperation, NSError* error) {
        if (completionBlock){
            completionBlock(@"-404");
        }
    }];
    if (downloadProgressBlock) {
        [op onDownloadProgressChanged:downloadProgressBlock];
    }
    
    [engine enqueueOperation:op];
    return op;
}

+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                              onCompletion:(void (^)(id data))completionBlock
{
    
    return [self getDataResponsePath:path
                              params:params
                          networkHUD:NetworkHUDLockScreenAndMsg
                        onCompletion:completionBlock];
}

+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                     params:(NSMutableDictionary *)params
                               isBackground:(BOOL)isBackground
                               onCompletion:(void (^)(id data))completionBlock
{
    return [self getDataResponsePath:path
                               params:params
                           networkHUD:isBackground?NetworkHUDBackground:NetworkHUDLockScreenAndMsg
                         onCompletion:completionBlock];
}

+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                                networkHUD:(NetworkHUD)networkHUD
                              onCompletion:(void (^)(id data))completionBlock
{
    return [self getDataResponsePath:path
                              params:params
                              isPost:NO
                          networkHUD:networkHUD
                        onCompletion:completionBlock];
}

+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                                    isPost:(BOOL)isPost
                                networkHUD:(NetworkHUD)networkHUD
                              onCompletion:(void (^)(id data))completionBlock
{
    if (networkHUD > 2)
    {
        [SVProgressHUD showWithStatus:@"请稍候..."];
    }
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:kServerHost];
    MKNetworkOperation *op =[engine operationWithPath:path
                                               params:params
                                           httpMethod:isPost?@"POST":@"GET"
                                                  ssl:isTrueEnvironment];
    DLog(@"url==%@\nparams==%@\n",op.url,params);
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        NSDictionary * response = [operation responseJSON];
        DLog(@"\n\nHTTPStatusCode %d\n\n", operation.HTTPStatusCode);
        DLog(@"response==%@",[operation responseString]);
        [[self class] handleResponse:response networkHUD:networkHUD];
        if (completionBlock)
            completionBlock(response);
    }errorHandler:^(MKNetworkOperation* completedOperation, NSError *error){
        NSDictionary *dic = [self getErrorDictionary];
        [[self class] handleResponse:dic networkHUD:networkHUD];
        if (completionBlock){
            completionBlock(dic);
        }
    }];
    
    [engine enqueueOperation:op];
    return op;
}

+ (MKNetworkOperation*)getDataResponsePath:(NSString *)path
                                     params:(NSMutableDictionary *)params
                                 networkHUD:(NetworkHUD)networkHUD
                                     target:(id)target
                               onCompletion:(void (^)(id data))completionBlock
{
    MKNetworkOperation *networkOperation = [self getDataResponsePath:path
                                                               params:params
                                                           networkHUD:networkHUD
                                                         onCompletion:completionBlock];
    if (target && [target respondsToSelector:@selector(addNet:)]) {
        [target performSelector:@selector(addNet:) withObject:networkOperation];
    }
    return networkOperation;
}

+ (void)handleResponse:(NSDictionary *)response networkHUD:(NetworkHUD)networkHUD
{
    NSString *message;
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        message = [response objectForKey:@"error"];
    }
    
    if (networkHUD>2) {
        [SVProgressHUD dismiss];
    }
    
    switch (networkHUD) {
        case NetworkHUDBackground:
            break;
        case NetworkHUDMsg:
            if (![NSString isNull:message]) {
                [iToast alertWithTitle:message];
            }
            break;
        case NetworkHUDLockScreen:
            break;
        case NetworkHUDLockScreenAndMsg:
            if (![NSString isNull:message]) {
                [iToast alertWithTitle:message];
            }
            break;
    }
}

+ (NSDictionary*)getErrorDictionary{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInteger:-404], @"resultStatus",
            @"网络异常，请检查网络",@"exception",
            nil];
}

@end
