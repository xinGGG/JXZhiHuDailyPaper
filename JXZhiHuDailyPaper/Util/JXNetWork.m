//
//  JXNetWork.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/14.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXNetWork.h"
#define TIMEOUT 20


@implementation JXNetWork


+(instancetype) defaultUtil
{
    static JXNetWork * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[JXNetWork alloc] init];
    });
    
    return sharedInstance;
}

-(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure
{
    [self POST:URLString parameters:parameters cache:NO ignoreParameters:nil success:^(id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)POST:(NSString *)URLString
 parameters:(id)parameters
      cache:(BOOL)cache
ignoreParameters:(NSArray *)ignoreParameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSLog(@"接口 ==== %@",URLString);
    NSLog(@"参数 ==== %@",parameter);
    NSString *cacheKey = @"";
    if (cache) {
        cacheKey = [self setupCacheWithUrl:URLString parameters:parameter removeParameterArray:ignoreParameters];
        NSLog(@"缓存配置key %@",cacheKey);
    }
    
    [manager POST:URLString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求线程------%@   : %@",URLString,[NSThread currentThread]);
        //只有成功返回 写入缓存
        [self Response:responseObject withCacheKey:cacheKey success:^(id responseObject) {
            success(responseObject);
        }];
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //成功+失败返回
        [self Response:nil withCacheKey:cacheKey success:^(id responseObject) {
            success(responseObject);
        }failure:^(NSError *subError) {
            JXError(subError.domain);
            failure(error);
        }];
        [manager.session finishTasksAndInvalidate];
    }];
}



-(void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure
{
    [self GET:URLString parameters:parameters cache:NO ignoreParameters:nil success:^(id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


-(void)GET:(NSString *)URLString
 parameters:(id)parameters
      cache:(BOOL)cache
ignoreParameters:(NSArray *)ignoreParameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSLog(@"接口 ==== %@",URLString);
    NSLog(@"参数 ==== %@",parameter);
    NSString *cacheKey = @"";
    if (cache) {
        cacheKey = [self setupCacheWithUrl:URLString parameters:parameter removeParameterArray:ignoreParameters];
        NSLog(@"缓存配置key %@",cacheKey);
    }
    
    [manager GET:URLString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求线程------%@   : %@",URLString,[NSThread currentThread]);
        //只有成功返回 写入缓存
        [self Response:responseObject withCacheKey:cacheKey success:^(id responseObject) {
            success(responseObject);
        }];
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //成功+失败返回
        [self Response:nil withCacheKey:cacheKey success:^(id responseObject) {
            success(responseObject);
        }failure:^(NSError *subError) {
            JXError(subError.domain);
            failure(error);
        }];
        [manager.session finishTasksAndInvalidate];
    }];
}



#pragma mark  上传下载
-(void)UPLOAD_SIGN:(NSString *)URLString
        parameters:(id)parameters
          formData:(void(^)(id formData))formDataBlock
          progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        formDataBlock(formData);
        
        //[formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"image" fileName:@"1.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadProgressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [manager.session finishTasksAndInvalidate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        [manager.session finishTasksAndInvalidate];
    }];
    
}


-(void)UPLOAD:(NSString *)URLString
   parameters:(id)parameters
     fileList:(NSArray*)fileList
        scale:(float)scale
     progress:(void(^)(NSProgress * uploadProgress))progress
      success:(void(^)(id responseObject))success
      failure:(void(^)(NSError *error))failure
{
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:URLString
                                    parameters:parameters
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        for (int i=0; i<fileList.count; i++) {
                                            UIImage *image =[fileList objectAtIndex:i];
                                            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, scale) name:@"image" fileName:@"1.jpg" mimeType:@"image/jpeg"];
                                        }
                                    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      progress(uploadProgress);
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          failure(error);
                          [manager.session finishTasksAndInvalidate];
                          
                      } else {
                          success(responseObject);
                          [manager.session finishTasksAndInvalidate];
                      }
                  }];
    [uploadTask resume];
}




-(void)DOWNLOAD:(NSString *)URLString
     parameters:(id)parameters
       fileList:(NSArray*)fileList
       progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
        success:(void(^)(id responseObject))success
        failure:(void(^)(NSError *error))failure
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
        
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            failure(error);
        } else {
            success(response);
        }
    }];
    [downloadTask resume];
    
}


//
//#pragma mark - 跳转界面
//- (void)push:(NSDictionary *)params
//{
//    // 类名
//    NSString *class =[NSString stringWithFormat:@"%@", @"WebViewController"];
//    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
//
//    // 从一个字串返回一个类
//    Class newClass = objc_getClass(className);
//    if (!newClass)
//    {
//        // 创建一个类
//        Class superClass = [NSObject class];
//        newClass = objc_allocateClassPair(superClass, className, 0);
//        // 注册你创建的这个类
//        objc_registerClassPair(newClass);
//    }
//    // 创建对象
//    id instance = [[newClass alloc] init];
//
//    NSMutableDictionary *propertys =[[NSMutableDictionary alloc]initWithDictionary:params];
//    [propertys setValue:@YES forKey:@"hideNavBarBackgroundColor"];
//
//    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        // 检测这个对象是否存在该属性
//        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
//            // 利用kvc赋值
//            [instance setValue:obj forKey:key];
//        }
//    }];
//
//    NSLog(@"%@",[[[UIApplication sharedApplication] activityViewController] class]);
//    if([[[UIApplication sharedApplication] activityViewController] isKindOfClass:[UINavigationController class]]){
//
//
//        UINavigationController *nav = (UINavigationController *)[[UIApplication sharedApplication] activityViewController];
//        [nav pushViewController:instance animated:NO];
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [nav setNavigationBarHidden:NO animated:YES];
//
//        });
//
//
//
//    }else{
//        [[[UIApplication sharedApplication] activityViewController].navigationController pushViewController:instance animated:NO];
//    }
//}
//

/**
 *  检测对象是否存在该属性
 */
//- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
//{
//    unsigned int outCount, i;
//
//    // 获取对象里的属性列表
//    objc_property_t * properties = class_copyPropertyList([instance
//                                                           class], &outCount);
//
//    for (i = 0; i < outCount; i++) {
//        objc_property_t property =properties[i];
//        //  属性名转成字符串
//        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//        // 判断该属性是否存在
//        if ([propertyName isEqualToString:verifyPropertyName]) {
//            free(properties);
//            return YES;
//        }
//    }
//    free(properties);
//
//    return NO;
//}

#pragma mark - 缓存处理
#pragma mark - 缓存配置key
- (NSString *)setupCacheWithUrl:(NSString *)Url parameters:(NSDictionary *)parameters removeParameterArray:(NSArray *)parameterArray{
    NSMutableDictionary *newParameter = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [newParameter setValue:Url forKey:@"cacheUrl"];
    
    for (NSString *str in parameterArray) {
        if ([[newParameter allKeys] containsObject:str]) {
            [newParameter removeObjectForKey:str];
        };
    }
    NSLog(@"%@",newParameter);
    NSString *headInfo = [self setupHeadInfo:newParameter];
    self.cacheKeyConlose = [headInfo md5HexDigest];
    return [headInfo md5HexDigest];
}

#pragma mark 缓存key生成
- (NSString *)setupHeadInfo:(NSDictionary *)parameters{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    for(NSString *key in [parameter allKeys]){
        if([@"(null)" isEqualToString:parameter[key]]){
            parameter[key]=@"";
        }
    }
    
    NSArray *allKey = [parameter allKeys];
    NSString *headInfo = [[NSString alloc] init];
    for(NSString *key in allKey){
        if([@"(null)" isEqualToString:parameter[key]]){
            parameter[key]=@"";
        }
    }
    NSArray *sortAllKey = [allKey SortOfList:allKey];
    for(int i=0;i<[sortAllKey count];i++){
        if(i != 0){
            headInfo = [headInfo stringByAppendingString:@"&"];
        }
        headInfo = [headInfo stringByAppendingString:[NSString stringWithFormat:@"%@=%@",sortAllKey[i],parameter[sortAllKey[i]]]];
    }
    return headInfo;
}
#pragma mark - 请求后数据统一处理
#pragma mark - 成功&写入缓存
- (void)Response:(id)response
    withCacheKey:(NSString *)CacheKey
         success:(void(^)(id responseObject))success{
    [self Response:response withCacheKey:CacheKey success:success failure:nil];
};
#pragma mark  成功&写入缓存&失败
- (void)Response:(id)response
    withCacheKey:(NSString *)CacheKey
         success:(void(^)(id responseObject))success
         failure:(void(^)(NSError *error))failure{
    
    //是否有请求数据
    BOOL isCache = (response == nil);
    
    if (isCache) {
        response = [[JXCache AppCache] objectForKey:CacheKey];
        if (response==nil) {
            //无数据传入
            //先看是否有缓存
            if (failure) {
                failure(ErrorTitle(@"No Cache -> Connect Error"));
                return;
            }
        }
    }
    //排空处理 防闪退保平安
    response = [NSDictionary nullDic:response];
    if (success) {
        if (CacheKey.length>0 && !isCache) {
            //写入缓存
            [[JXCache AppCache] setObject:response forKey:CacheKey];
        }
        //回调
        if(response != nil){
            success(response);
        }else{
            success(nil);
        }
    }else{
        success(nil);
    }
    
    
}


#pragma mark - 网络请求取消
#pragma mark -
-(void)cancelAllRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

@end
