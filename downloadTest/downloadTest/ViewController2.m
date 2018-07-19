//
//  ViewController2.m
//  downloadTest
//
//  Created by 李旭萌 on 2018/7/9.
//  Copyright © 2018年 李旭萌. All rights reserved.
//

#import "ViewController2.h"
#import "DownloadManager.h"
@interface ViewController2 ()
{
    
    NSString * urlStr;
    NSString * fileId;
}
@property(nonatomic,strong)DownloadManager * manager;
@end

@implementation ViewController2
//继续
- (IBAction)click:(id)sender {

    self.manager = [[DownloadManager alloc]initWithUrl:[NSURL URLWithString:urlStr] andWithFileId:fileId andWithProgress:self.progress];
}
//取消
- (IBAction)supp:(id)sender {
 
    [self.manager cancel];
    
}
- (IBAction)delete:(id)sender {
    [self.manager removeFile];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    urlStr = @"https://images.apple.com/media/cn/macbook-pro/2016/b4a9efaa_6fe5_4075_a9d0_8e4592d6146c/films/design/macbook-pro-design-tft-cn-20161026_1536x640h.mp4";
    
    fileId = @"456";
    
    self.manager = [[DownloadManager alloc]initWithUrl:[NSURL URLWithString:urlStr] andWithFileId:fileId andWithProgress:self.progress];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
