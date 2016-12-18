//
//  JXNetWork.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/14.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    CacheDisposeWrite = 1,
    CacheDisposeRead,
}CacheDispose;


@interface JXNetWork : NSObject


+(instancetype) defaultUtil;


//POST方法
-(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure;

-(void)POST:(NSString *)URLString
 parameters:(id)parameters
      cache:(BOOL)cache
ignoreParameters:(NSArray *)ignoreParameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure;

//GET方法
-(void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure;

-(void)GET:(NSString *)URLString
 parameters:(id)parameters
      cache:(BOOL)cache
ignoreParameters:(NSArray *)ignoreParameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure;

//带签名上传文件
-(void)UPLOAD_SIGN:(NSString *)URLString
        parameters:(id)parameters
          formData:(void(^)(id formData))formDataBlock
          progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure;

//上传文件
-(void)UPLOAD:(NSString *)URLString
   parameters:(id)parameters
     fileList:(NSArray*)fileList
        scale:(float)scale
     progress:(void(^)(NSProgress * uploadProgress))progress
      success:(void(^)(id responseObject))success
      failure:(void(^)(NSError *error))failure;

//下载文件
-(void)DOWNLOAD:(NSString *)URLString
     parameters:(id)parameters
       fileList:(NSArray*)fileList
       progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
        success:(void(^)(id responseObject))success
        failure:(void(^)(NSError *error))failure;


//获取缓存key
@property (nonatomic,strong) NSString *cacheKeyConlose;
- (NSString *)setupCacheWithUrl:(NSString *)Url parameters:(NSDictionary *)parameters removeParameterArray:(NSArray *)parameterArray;

-(void)cancelAllRequest;



@end
