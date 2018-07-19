//
//  DownloadManager.h
//  PaasCloud
//
//  Created by 李旭萌 on 2018/7/9.
//  Copyright © 2018年 zhangshaohong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface DownloadManager : NSObject
/**
 初始化下载任务并开始

 @param url 链接
 @param fileId 文件id 因为同一文件链接会有变动，所以用文件id做唯一标识
 @param progress 进度条
 @return 下载对象
 */
-(instancetype)initWithUrl:(NSURL *)url andWithFileId:(NSString*)fileId andWithProgress:(UIProgressView*)progress;

/**
 取消下载（暂停）
 */
- (void)cancel;

/**
 删除任务和文件
 */
-(void)removeFile;

@end
