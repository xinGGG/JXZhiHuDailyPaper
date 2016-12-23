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

///-----------
/// URL Scheme
///-----------

#define JX_URL_SCHEME @"mvvmreactivecocoa"

///----------------------
/// Persistence Directory
///----------------------

#define JX_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#endif /* JXConfig_h */
