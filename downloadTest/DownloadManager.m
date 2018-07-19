//
//  DownloadManager.m
//  PaasCloud
//
//  Created by 李旭萌 on 2018/7/9.
//  Copyright © 2018年 zhangshaohong. All rights reserved.
//

#import "DownloadManager.h"

@interface DownloadManager()

@property(nonatomic,strong)NSURL * url;//下载链接
@property(nonatomic,strong)NSString * fileId;//文件id，唯一标志
@property(nonatomic,strong)NSString * filePath;//文件路径
@property(nonatomic,strong)NSString * fileName;//文件路径 + 文件名

@property(nonatomic,strong)NSFileHandle * fileHandle;//文件句柄

@property(nonatomic,strong)AFURLSessionManager * manager;
@property(nonatomic,strong)NSURLSessionDataTask * task;
@property(nonatomic,strong)NSMutableURLRequest * request;//请求

@property(nonatomic,assign)long long  completeSize;//已下载文件长度
@property(nonatomic,assign)long long  totalSize;//总文件长度


@property(nonatomic,strong)UIProgressView * progress;//进度条


@end

@implementation DownloadManager


#pragma mark 初始化
- (instancetype)initWithUrl:(NSURL *)url andWithFileId:(NSString*)fileId andWithProgress:(UIProgressView*)progress{
    if (self = [super init]) {
        
        __weak typeof (self)weakSelf = self;
        self.url = url;
        self.fileId = fileId;
        self.progress = progress;
        self.progress.progress = 0;
        
        //初始化task
        self.task = [self.manager dataTaskWithRequest:self.request uploadProgress:nil downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            
            if (!weakSelf.totalSize) {
                weakSelf.totalSize = downloadProgress.totalUnitCount;
            }
            
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            NSLog(@"完成");
        }];
        
        
        //接收之初
        [self.manager setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSURLResponse * _Nonnull response) {
            
            self->_fileHandle = [NSFileHandle fileHandleForWritingAtPath:weakSelf.fileName];
            return NSURLSessionResponseAllow;
        }];
        //接收之时
        [self.manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
            weakSelf.completeSize = [weakSelf.fileHandle seekToEndOfFile];
            [weakSelf.fileHandle writeData:data];
            
            // 主线程执行
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.progress.progress = (float)weakSelf.completeSize/(float)weakSelf.totalSize;
            });
            
        }];
    }
    [self.task resume];
    return self;
}

#pragma mark 各种懒加载
//计算文件进度，设置request
-(NSMutableURLRequest *)request{
    if (!_request) {
        _request = [[NSMutableURLRequest alloc]initWithURL:self.url];
        
        //如果没有该目录，就创建一个
        [[NSFileManager defaultManager] createDirectoryAtPath:self.filePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        //如果该目录下没有该文件就创建该文件
        if (![[NSFileManager defaultManager] fileExistsAtPath:self.fileName]) {
            
            [[NSFileManager defaultManager] createFileAtPath:self.fileName contents:nil attributes:nil];
            
        }else{
            //有就计算文件长度
            self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.fileName];
            self.completeSize = [self.fileHandle seekToEndOfFile];
            
            NSString *range = [NSString stringWithFormat:@"bytes=%lld-", self.completeSize];
            [_request setValue:range forHTTPHeaderField:@"Range"];
        }
    }
    return _request;
}
- (AFURLSessionManager *)manager{
    if (!_manager) {
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:self.url.absoluteString];
        _manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
        
    }
    return _manager;
}
-(NSString *)filePath{
    if (!_filePath) {
        _filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"download"];
    }
    return _filePath;
}

- (NSString *)fileName{
    if (!_fileName) {
        //用文件id拼接一下，保证路径唯一性
        _fileName = [_filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",self.fileId, self.url.lastPathComponent]];
    }
    return _fileName;
}

#pragma mark 取消
- (void)cancel{
    [self.task cancel];
}
#pragma mark 删除
//删除文件
-(void)removeFile{
    [self.task cancel];
    self.progress.progress = 0;
    [[NSFileManager defaultManager]removeItemAtPath:self.fileName error:nil];
}


@end
