//
//  Downloader.h
//  downloadTest
//
//  Created by 李旭萌 on 2018/7/18.
//  Copyright © 2018年 李旭萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Downloader : NSObject

/**
 最大同时下载数默认为3
 */
@property(nonatomic,assign)NSInteger maxDownloadManger;

/**
 装下载任务的数组
 */
@property(nonatomic,strong)NSMutableArray * downloadArray;


/**
 单利

 @return 管理下载的对象
 */
+ (instancetype)defautManager;
@end
