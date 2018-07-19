//
//  Downloader.m
//  downloadTest
//
//  Created by 李旭萌 on 2018/7/18.
//  Copyright © 2018年 李旭萌. All rights reserved.
//

#import "Downloader.h"
#import "DownloadManager.h"

@implementation Downloader

+ (instancetype)defautManager {
    
    static Downloader * def = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        def = [self new];
    });
    
    return def;
}

#pragma mark 属性懒加载
- (NSMutableArray *)downloadArray{
    if (!_downloadArray) {
        _downloadArray = [NSMutableArray array];
    }
    return _downloadArray;
}
- (NSInteger)maxDownloadManger{
    if (!_maxDownloadManger) {
        _maxDownloadManger = 3;
    }
    return _maxDownloadManger;
}
@end
