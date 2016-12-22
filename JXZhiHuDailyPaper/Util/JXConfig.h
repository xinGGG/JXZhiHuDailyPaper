//
//  JXConfig.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/14.
//  Copyright © 2016年 ljx. All rights reserved.
//

#ifndef JXConfig_h
#define JXConfig_h
///------------
/// Navigation
///------------

#define JXNowNavigation                  [[UIApplication sharedApplication] activityViewController].navigationController
///------------
/// Client Info
///------------

#define JX_CLIENT_ID     @"ef5834ea86b53233dc41"
#define JX_CLIENT_SECRET @"6eea860464609635567d001b1744a052f8568a99"

///-----------
/// SSKeychain
///-----------

#define JX_SERVICE_NAME @"com.leichunfeng.MVVMReactiveCocoa"
#define JX_RAW_LOGIN    @"RawLogin"
#define JX_PASSWORD     @"Password"
#define JX_ACCESS_TOKEN @"AccessToken"

///-----------
/// URL Scheme
///-----------

#define JX_URL_SCHEME @"mvvmreactivecocoa"

///----------------------
/// Persistence Directory
///----------------------

#define JX_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject


#endif /* JXConfig_h */
